//
//  User.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

struct User {
    let email: String
}

extension User: Identifiable {
    var id: String { email }
}
