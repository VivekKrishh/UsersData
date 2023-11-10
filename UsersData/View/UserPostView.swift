//
//  UserPostView.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import SwiftUI

struct UserPostView: View {
    @StateObject private var viewModel = UserPostViewModel()
    @State var selectedUser: User?
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                        Text(post.body)
                            .font(.subheadline)
                    }
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .foregroundColor(.black)
                }
            }
        }
        .navigationTitle("\(selectedUser?.name ?? "")")
        .listStyle(.plain)
        .onAppear {
            Task {
                if let userId = selectedUser?.id {
                    await viewModel.getUserPost(for: userId)
                }
            }
        }
    }
}

struct UserPostView_Previews: PreviewProvider {
    static var previews: some View {
        UserPostView()
    }
}
