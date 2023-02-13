//
//  APIClientAdapter.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

extension APIClient: UsersRepository {
    func fetchUsers() async throws -> [User] {
        return try await fetchRandomUsers().map(User.init(dto:))
    }
}

extension User {
    init(dto: UserDTO) {
        email = dto.email
    }
}
