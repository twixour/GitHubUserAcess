//
//  GitHubUser.swift
//  GitHubUserAcess
//
//  Created by Raushan Kashyap on 06/07/23.
//

import Foundation


struct GitHubUser: Codable {
    let login: String
    let avatarUrl: String
    let bio: String
}


enum GHError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}


func getUser(username: String) async throws -> GitHubUser {
    //let endpoint1 = "https://instiapp.vercel.app/login"
    let endpoint = "https://api.github.com/users/\(username)"
    
    guard let url = URL(string: endpoint) else {
        throw GHError.invalidURL
        
    }
    let (data, response) = try await URLSession.shared.data(from:url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GHError.invalidResponse
    }
    
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUser.self, from:data)
    } catch {
        throw GHError.invalidData
    }
}
