//
//  PostEntity+CoreDataProperties.swift
//  UsersData
//
//  Created by Vivek on 10/11/23.
//
//

import Foundation
import CoreData


extension PostEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PostEntity> {
        return NSFetchRequest<PostEntity>(entityName: "PostEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var userId: Int16
    @NSManaged public var title: String?
    @NSManaged public var body: String?
    @NSManaged public var user: UserEntity?

}

extension PostEntity : Identifiable {

}
