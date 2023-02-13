//
//  UsersRepository.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

protocol UsersRepository {
    func fetchUsers() async throws -> [User]
}
