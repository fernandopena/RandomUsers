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
    
    private let usersRespository: UsersRepository
    
    init(usersRespository: UsersRepository) {
        self.usersRespository = usersRespository
    }
    
    func fetchUsers() {
        isLoading = true
        usersRespository.fetchUsers { result in
            self.isLoading = false
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                // Handle error
                print("ERROR: \(error)")
            }
        }
        
    }
}
