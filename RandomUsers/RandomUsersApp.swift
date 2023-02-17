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
        let usersPublisher = makeUsersPublisher
        let usersRespository = UsersRepositoryAdapter(usersPublisher: usersPublisher)
        let viewModel = UsersViewModel(usersRespository: usersRespository)
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

// RandomUserAPIClient Adapter
extension RandomUserAPIClient {
    func fetchPublisher() -> AnyPublisher<[User], Error> {
        Deferred {
            Future {
                try await self.fetchRandomUsers()
            }.map{ $0.map(User.init(dto:)) }
        }.eraseToAnyPublisher()
    }
}

extension User {
    init(dto: UserDTO) {
        email = dto.email
    }
}

// Bridge `AuthenticatorProtocol` from async/await to Combine world.
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

// Convert from Combine Publuisher to `UsersRepository` required by the ViewModel.
class UsersRepositoryAdapter: UsersRepository {
    private let usersPublisher: () -> AnyPublisher<[User], Error>
    private var cancellable: AnyCancellable?

    init(usersPublisher: @escaping () -> AnyPublisher<[User], Error>) {
        self.usersPublisher = usersPublisher
    }
    
    func fetchUsers(completion completionHandler: @escaping Completion) {
        cancellable = usersPublisher().sink(receiveCompletion: { completion in
            switch completion {
            case .failure(let error):
                completionHandler(.failure(error))
            case .finished:
                break
            }
        }, receiveValue: { value in
            completionHandler(.success(value))
        })
    }
}
