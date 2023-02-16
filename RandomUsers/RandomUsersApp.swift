//
//  RandomUsersApp.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import SwiftUI

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
        let usersRepository: UsersRepository = LoggerDecorator(decoratee: BiometryDecorator(decoratee: MainQueueDispatchDecorator(decoratee: RandomUserAPIClient())))
        let viewModel = UsersViewModel(usersRespository: usersRepository)
        return UsersView(viewModel: viewModel)
    }
}
