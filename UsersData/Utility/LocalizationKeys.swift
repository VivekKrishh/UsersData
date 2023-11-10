//
//  LocalizationKeys.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import Foundation

protocol Localized {
    var localized: String  { get }
}

enum UsersData: String , Localized {
    case errorInvalidEndPoint
    case errorRemoteDataParsingFailed
    case errorDataTask
    case errorUnexpectedStatusCode
    
    var localized: String {
        self.rawValue.localized
    }
}
