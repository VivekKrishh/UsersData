//
//  StringExtensions.swift
//  UsersData
//
//  Created by Vivek on 09/11/23.
//

import Foundation

extension String {
    // MARK: - Localized String
    var localized: Self {
        NSLocalizedString(self, comment: self)
    }
}
