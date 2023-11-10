//
//  ResponseError.swift
//  UsersData
//
//  Created by Vivek on 08/11/23.
//

import Foundation

enum ResponseError: Error {
    case invalidURL
    case decoding
    case dataTask
    case unexpectedStatusCode
    
    var description: String {
        switch self {
        case .invalidURL:
            return UsersData.errorInvalidEndPoint.localized
        case .decoding:
            return UsersData.errorRemoteDataParsingFailed.localized
        case .dataTask:
            return UsersData.errorDataTask.localized
        case .unexpectedStatusCode:
            return UsersData.errorUnexpectedStatusCode.localized
        }
    }
}
