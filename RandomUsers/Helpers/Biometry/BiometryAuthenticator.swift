//
//  BiometryAuthenticator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 13/02/2023.
//

import Foundation
import LocalAuthentication

final class BiometryAuthenticator {
    let context: LAContext = LAContext()
    
    func authenticate(localizedReason: String = "Biometry") async throws -> Void {
        let result = try await context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReason)
        guard result else {
            throw Error.failedToAuthenticate
        }
    }
    
    enum Error: Swift.Error {
        case failedToAuthenticate
    }
}
