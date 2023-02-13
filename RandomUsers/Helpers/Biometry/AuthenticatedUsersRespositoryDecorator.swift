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
    let context: LAContext
    let localizedReason: String

    internal init(decoratee: UsersRepository,
                  context: LAContext = LAContext(),
                  localizedReason: String = "Biometry") {
        self.decoratee = decoratee
        self.context = context
        self.localizedReason = localizedReason
    }
    
    func fetchUsers() async throws -> [User] {
        let result = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                                      localizedReason: localizedReason)
        guard result else {
            throw BiometyError.failedToAuthenticate
        }
        return try await decoratee.fetchUsers()
    }
}

enum BiometyError: Error {
    case failedToAuthenticate
}
