//
//  FakeUsersRepository.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation

struct FakeUsersRepository: UsersRepository {
    func fetchUsers() async throws -> [User] {
        [User(email: "dummy@email.com")]
    }
}
