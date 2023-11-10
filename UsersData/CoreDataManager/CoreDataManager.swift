//
//  CoreDataManager.swift
//  UsersData
//
//  Created by Vivek on 10/11/23.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    private init() {
        persistentContainer = NSPersistentContainer(name: "UsersData")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data \(error)")
            }
        }
    }
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}

extension CoreDataManager {
    
    func getAllUsers() -> [UserEntity] {
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    func addUser(id: Int, name: String, username: String, email: String, posts: [Post]) {
        if !checkIfUserAlreadyExist(with: id) {
            let newUser = UserEntity(context: viewContext)
            newUser.id = Int16(id)
            newUser.name = name
            newUser.username = username
            newUser.email = email
            var userPosts: Set<PostEntity> = []
            for post in posts {
                let newPost = PostEntity(context: viewContext)
                newPost.id = Int16(post.id)
                newPost.userId = Int16(post.userId)
                newPost.title = post.title
                newPost.body = post.body
                newPost.user = newUser
                userPosts.insert(newPost)
            }
            
            print(userPosts)
            newUser.post = userPosts as NSSet
            saveContext()
        }
    }
    
    func deleteUser(user: UserEntity) {
        viewContext.delete(user)
        saveContext()
    }
    
    func checkIfUserAlreadyExist(with UserId: Int) -> Bool {
        return getAllUsers().filter { $0.id == UserId }.count > 0
    }
}
