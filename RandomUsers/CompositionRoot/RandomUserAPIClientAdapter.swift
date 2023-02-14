//
//  RandomUserAPIClientAdapter.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

extension RandomUserAPIClient: UsersRepository {
    func fetchUsers(completion: @escaping Completion) {
        Task {
            do {
                let usersDto = try await fetchRandomUsers()
                let users = usersDto.map(User.init(dto:))
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

extension User {
    init(dto: UserDTO) {
        email = dto.email
    }
}
