//
//  BiometryAuthenticator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation
import LocalAuthentication

protocol BiometryAuthenticatorProtocol {
    func authenticate() async throws -> Void
}

final class BiometryAuthenticator: BiometryAuthenticatorProtocol {
    let context: LAContext
    let localizedReason: String
    
    internal init(context: LAContext = LAContext(),
                  localizedReason: String = "Biometry") {
        self.context = context
        self.localizedReason = localizedReason
    }
    
    func authenticate() async throws -> Void {
        let result = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason)
        guard result else {
            throw AuthenticationError.failedToAuthenticate
        }
    }
}

enum AuthenticationError: Error {
    case failedToAuthenticate
}
