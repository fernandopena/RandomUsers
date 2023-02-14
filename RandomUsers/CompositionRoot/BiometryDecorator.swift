//
//  BiometryDecorator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

final class BiometryDecorator<T> {
    private let decoratee: T
    private let authenticator: AuthenticatorProtocol
    
    init(decoratee: T,
         authenticator: AuthenticatorProtocol = LABiometryAuthenticator()) {
        self.decoratee = decoratee
        self.authenticator = authenticator
    }
}

extension BiometryDecorator: UsersRepository where T == UsersRepository {
    func fetchUsers(completion: @escaping Completion) {
        Task {
            do {
                try await authenticator.authenticate()
                decoratee.fetchUsers(completion: completion)
            } catch {
                completion(.failure(error))
            }
        }
    }
}
