//
//  User.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import Foundation

// Source: https://jsonplaceholder.typicode.com/users

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let email: String
}
