//
//  APIEndPoint.swift
//  UsersData
//
//  Created by Vivek on 08/11/23.
//

import Foundation

enum APIEndPoint {
    case fetchUsers
    case fetchAllPosts
    case fetchPosts(userId: Int)
    
    var path: String {
        switch self {
        case .fetchUsers:
            return APIConstants.users
        case .fetchAllPosts:
            return APIConstants.allPosts
        case .fetchPosts(userId: let userId):
            return APIConstants.users + "/\(userId)/posts"
        }
    }
}
