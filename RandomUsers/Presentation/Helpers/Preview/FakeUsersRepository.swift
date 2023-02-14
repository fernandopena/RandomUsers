//
//  FakeUsersRepository.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation

struct FakeUsersRepository: UsersRepository {
    func fetchUsers(completion: @escaping Completion) {
        completion(.success([User(email: "dummy@email.com")]))
    }
}
