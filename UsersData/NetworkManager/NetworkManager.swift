//
//  NetworkManager.swift
//  UsersData
//
//  Created by Vivek on 08/11/23.
//

import Foundation

protocol NetworkProtocol {
    func getRequest<T: Codable>(url: URL?, expecting: T.Type) async throws -> T
}

final class NetworkManager: NetworkProtocol {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getRequest<T: Codable>(url: URL?, expecting: T.Type) async throws -> T {
        guard let url = url else {
            throw ResponseError.invalidURL
        }
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw ResponseError.unexpectedStatusCode
            }
            
            do {
                let decodedData = try JSONDecoder().decode(expecting, from: data)
                return decodedData
            } catch {
                throw ResponseError.decoding
            }
        }
        catch {
            throw ResponseError.dataTask 
        }
        
    }
}
