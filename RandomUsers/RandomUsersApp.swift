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
        RandomUserAPIClient()
            .fetchPublisher()
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

