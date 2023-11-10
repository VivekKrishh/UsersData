//
//  UserEntity+CoreDataProperties.swift
//  UsersData
//
//  Created by Vivek on 10/11/23.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var username: String?
    @NSManaged public var post: NSSet?

}

// MARK: Generated accessors for post
extension UserEntity {

    @objc(addPostObject:)
    @NSManaged public func addToPost(_ value: PostEntity)

    @objc(removePostObject:)
    @NSManaged public func removeFromPost(_ value: PostEntity)

    @objc(addPost:)
    @NSManaged public func addToPost(_ values: NSSet)

    @objc(removePost:)
    @NSManaged public func removeFromPost(_ values: NSSet)

}

extension UserEntity : Identifiable {

}
