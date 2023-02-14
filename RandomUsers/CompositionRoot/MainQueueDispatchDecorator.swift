//
//  MainQueueDispatchDecorator.swift
//  RandomUsers
//
//  Created by Fernando Pena on 14/02/2023.
//

import Foundation

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    func dispatch(completion: @escaping () -> Void) {
        DispatchQueue.main.async(execute: completion)
    }
}

extension MainQueueDispatchDecorator: UsersRepository where T == UsersRepository {
    func fetchUsers(completion: @escaping Completion) {
        decoratee.fetchUsers { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}
