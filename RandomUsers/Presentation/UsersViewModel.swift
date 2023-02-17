//
//  UsersViewModel.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

typealias FetchUsersCompletion = (Result<[User], Error>) -> Void

class UsersViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false

    let fetchUsersClosure: (@escaping FetchUsersCompletion) -> Void
    
    init(fetchUsersClosure:  @escaping (@escaping FetchUsersCompletion) -> Void) {
        self.fetchUsersClosure = fetchUsersClosure
    }
    
    func fetchUsers() {
        isLoading = true
        fetchUsersClosure { result in
            self.isLoading = false
            switch result {
            case .success(let users):
                self.users = users
            case .failure:
                // Handle error
                break
            }
        }
//        usersRespository() { result in
//            self.isLoading = false
//            switch result {
//            case .success(let users):
//                self.users = users
//            case .failure:
//                // Handle error
//                break
//            }
//        }
    }
}
