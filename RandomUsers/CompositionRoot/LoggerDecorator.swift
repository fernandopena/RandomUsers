//
//  LoggerDecorator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

final class LoggerDecorator<T> {
    private let decoratee: T
    private let logger: LoggerProtocol

    init(decoratee: T,
         logger: LoggerProtocol = LocalLogger()) {
        self.decoratee = decoratee
        self.logger = logger
    }
}

extension LoggerDecorator: UsersRepository where T == UsersRepository {
    func fetchUsers(completion: @escaping Completion) {
        decoratee.fetchUsers { [weak self] result in
            switch result {
            case .success: break
            case .failure(let error): self?.logger.log("ERROR: \(error)")
            }
            completion(result)
        }
    }
}

