//
//  UsersView.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import SwiftUI

struct UsersView: View {
    @ObservedObject var viewModel: UsersViewModel
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else {
                List {
                    ForEach(viewModel.users) { user in
                        Text("\(user.email)")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchUsers()
        }
    }
}

struct UsersView_Previews: PreviewProvider {
    static var previews: some View {
        UsersView(viewModel: UsersViewModel(usersRespository: FakeUsersRepository()))
    }
}
