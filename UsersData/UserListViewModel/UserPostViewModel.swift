//
//  UserPostViewModel.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//
import Foundation

class UserPostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @MainActor
    func getUserPost(for userId: Int) async {
        let url = URL(string: APIEndPoint.fetchPosts(userId: userId).path)
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            posts = try await NetworkManager.shared.getRequest(url: url, expecting: [Post].self)
            print(posts)
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
        
    }
}
