//
//  UsersViewModel.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    
    private let usersRespository: UsersRepository
    
    init(usersRespository: UsersRepository) {
        self.usersRespository = usersRespository
    }
    
    func fetchUsers() {
        isLoading = true
        usersRespository.fetchUsers { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let users):
                    self.users = users
                case .failure:
                    break
                }
            }
        }
    }
}
