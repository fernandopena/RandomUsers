//
//  RandomUsersApp.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import SwiftUI
import Combine

@main
struct RandomUsersApp: App {
    var body: some Scene {
        WindowGroup {
            makeUsersView()
        }
    }
}

extension RandomUsersApp {
    func makeUsersView() -> UsersView {
        let viewModel = UsersViewModel(usersPublisher: makeUsersPublisher)
        return UsersView(viewModel: viewModel)
    }

    func makeUsersPublisher() -> AnyPublisher<[User], Error> {
        LABiometryAuthenticator()
            .authenticatePublisher()
            .flatMap { RandomUserAPIClient().fetchPublisher() }
            .logErrors(to: LocalLogger())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension UsersRepository {
    func fetchPublisher() -> AnyPublisher<[User], Error> {
        Deferred {
            Future(self.fetchUsers)
        }.eraseToAnyPublisher()
    }
}

extension AuthenticatorProtocol {
    func authenticatePublisher() -> AnyPublisher<Void, Error> {
        Deferred {
            Future {
                try await self.authenticate()
            }
        }.eraseToAnyPublisher()
    }
}

// Operator that logs errors on a `LoggerProtocol` instance
extension Publisher {
    func logErrors(to logger: LoggerProtocol) -> AnyPublisher<Output, Failure> {
        self.catch { error -> Fail in
            logger.log("ERROR: \(error)")
            return Fail(error: error)
        }.eraseToAnyPublisher()
    }
}

