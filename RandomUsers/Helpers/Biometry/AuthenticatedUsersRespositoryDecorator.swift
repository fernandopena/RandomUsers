//
//  AuthenticatedUsersRespositoryDecorator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation
import LocalAuthentication

class AuthenticatedUsersRespositoryDecorator: UsersRepository {
    let decoratee: UsersRepository
    let biometryAuthenticator: BiometryAuthenticator

    internal init(decoratee: UsersRepository,
                  biometryAuthenticator: BiometryAuthenticator = BiometryAuthenticator()) {
        self.decoratee = decoratee
        self.biometryAuthenticator = biometryAuthenticator
    }
    
    func fetchUsers() async throws -> [User] {
        try await biometryAuthenticator.authenticate()
        return try await decoratee.fetchUsers()
    }
}
