//
//  LABiometryAuthenticator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation
import LocalAuthentication

final class LABiometryAuthenticator: AuthenticatorProtocol {
    private let context: LAContext
    private let localizedReason: String
    
    init(context: LAContext = LAContext(),
         localizedReason: String = "Biometry") {
        self.context = context
        self.localizedReason = localizedReason
    }
    
    func authenticate() async throws -> Void {
        let result = try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason)
        if result == false {
            throw BiometryError.authenticationFailed
        }
    }
}

enum BiometryError: Error {
    case authenticationFailed
}
