//
//  BiometryAuthenticator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation
import LocalAuthentication

struct BiometryAuthenticator {
    private func asyncAuthentication(localizedReason: String = "Biometry") async throws -> Bool {
        try await LAContext().evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason)
    }
}
