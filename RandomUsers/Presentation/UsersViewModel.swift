//
//  UsersViewModel.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation
import Combine

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    private var cancellable: AnyCancellable?
    private let usersPublisher: () -> AnyPublisher<[User], Error>
    
    init(usersPublisher: @escaping () -> AnyPublisher<[User], Error>) {
        self.usersPublisher = usersPublisher
    }
    
    func fetchUsers() {
        isLoading = true
        cancellable = usersPublisher()
            .sink(receiveCompletion: { [weak self] _ in
            self?.isLoading = false
        }, receiveValue: { [weak self] users in
            self?.users = users
        })
    }
}
