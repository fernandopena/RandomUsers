//
//  UsersRepository.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

protocol UsersRepository {
    typealias Completion = (Result<[User], Error>) -> Void
    func fetchUsers(completion: @escaping Completion)
}

