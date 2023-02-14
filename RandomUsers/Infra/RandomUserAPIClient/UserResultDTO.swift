//
//  UserResultDTO.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

struct UsersResponseDTO: Decodable {
    let results: [UserDTO]
}

struct UserDTO: Decodable {
    let email: String
}
