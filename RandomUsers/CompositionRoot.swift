//
//  CompositionRoot.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation
import Combine

// Create the UsersRepository for the UsersView
final class UsersRepositoryComposer: UsersRepository {
    // fetchUsersPublisher to async/await to be compliant with `UsersRepository` protocol
    func fetchUsers() async throws -> [User] {
        try await fetchUsersPublisher().async()
    }
    
    func fetchUsersPublisher() -> AnyPublisher<[User], Error> {
        let authenticator = BiometryAuthenticator()
        let apiClient = RandomUserAPIClient()
        return authenticator
            .authenticatePublisher()
            .flatMap { _ in apiClient.fetchRandomUsersPublisher() }
            .map { $0.map(User.init(dto:)) }
            .eraseToAnyPublisher()
    }
}

// BiometryAuthenticator async/await to Publisher
extension BiometryAuthenticator {
    func authenticatePublisher() -> Future<Void, Error> {
        Future {
            try await self.authenticate()
        }
    }
}

// RandomUserAPIClient async/await to Publisher
extension RandomUserAPIClient {
    func fetchRandomUsersPublisher(results: Int = 10) -> Future<[UserDTO], Error> {
        Future {
            return try await self.fetchRandomUsers(results: results)
        }
    }
}

// Map UserDTO -> User
extension User {
    init(dto: UserDTO) {
        email = dto.email
    }
}
