//
//  ContentView.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import SwiftUI

struct UserListView: View {
    @ObservedObject var monitor = NetworkMonitor()
    @StateObject private var viewModel = UserListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink<UserCellView, UserPostView> {
                        UserPostView(selectedUser: user)
                    } label: {
                        UserCellView(name: user.name, email: user.email)
                    }
                }
            }
            .alert("Something went wrong", isPresented: $viewModel.showAlert, actions: {
                Button("Ok"){}
            })
            .overlay(content: {
                if viewModel.isLoading {
                    ProgressView()
                        .foregroundColor(.black)
                }
            })
            .navigationBarItems(trailing:Button(
                action: {
                    print("Sync tapped")
                    viewModel.performOfflineSync()                    
                }, label: {
                    Text("Sync")
                        .font(.title3)
                }
            ))
            .navigationTitle("Users")
            .font(.largeTitle)
            .listStyle(.plain)
            .onAppear {
                Task {
                    await viewModel.fetchUsers()
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView()
    }
}

struct UserCellView: View {
    @State var name: String
    @State var email: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(name)
                .font(.title)
            Text(email)
                .font(.title3)
        }
    }
}
