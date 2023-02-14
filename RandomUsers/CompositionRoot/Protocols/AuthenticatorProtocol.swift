//
//  AuthenticatorProtocol.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

protocol AuthenticatorProtocol {
    func authenticate() async throws -> Void
}
