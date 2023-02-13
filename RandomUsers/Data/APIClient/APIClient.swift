//
//  APIClient.swift
//  RandomUsers
//
//  Created by Fernando Pena on 09/02/2023.
//

import Foundation

class APIClient {
    let session: URLSession = .shared
    let apiEndpoint: String = "https://randomuser.me/api/"
    
    func fetchRandomUsers(results: Int = 10) async throws -> [UserDTO] {
        let url = URL(string: "https://randomuser.me/api/?results=\(results)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let response = try decoder.decode(UsersResponseDTO.self, from: data)
        return response.results
    }
}


