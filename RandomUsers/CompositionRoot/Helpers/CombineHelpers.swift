//
//  CombineHelpers.swift
//  RandomUsers
//
//  Created by Fernando Pena on 16/02/2023.
//

import Foundation
import Combine

// async/await -> Combine Publisher
extension Future where Failure == Error {
    convenience init(operation: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let output = try await operation()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}
