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
        Task {
            do {
                let users = try await usersRespository.fetchUsers()
                await MainActor.run {
                    self.users = users
                }
            } catch {
                // Handle error
            }
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
