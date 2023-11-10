//
//  UserListViewModel.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import Foundation

class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var offlineUsers: [UserEntity] = []
    @Published var isLoading: Bool = false
    @Published var showAlert = false
    @Published var errorMessage: String?
    
    @Published var allPosts: [Post] = []

    @MainActor
    func getAllPost() async {
        let url = URL(string: APIEndPoint.fetchAllPosts.path)
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            allPosts = try await NetworkManager.shared.getRequest(url: url, expecting: [Post].self)
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
        
    }
    
    @MainActor
    func fetchUsers() async {
        let usersUrl = URL(string: APIEndPoint.fetchUsers.path)
        let allPosturl = URL(string: APIEndPoint.fetchAllPosts.path)
        isLoading.toggle()
        defer {
            isLoading.toggle()
        }
        do {
            users = try await NetworkManager.shared.getRequest(url: usersUrl, expecting: [User].self)
            allPosts = try await NetworkManager.shared.getRequest(url: allPosturl, expecting: [Post].self)
        } catch {
            showAlert = true
            errorMessage = error.localizedDescription
        }
    }
    
    func performOfflineSync() {
        for user in users {
            let userPosts = allPosts.filter({$0.userId == user.id})
            CoreDataManager.shared.addUser(id: user.id, name: user.name, username: user.username, email: user.email, posts: userPosts)
        }
    }
    
    func getOfflineUsers() -> [UserEntity] {
        offlineUsers = offlineUsers.count > 0 ? [] : CoreDataManager.shared.getAllUsers()
        return offlineUsers
    }
}
