//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation
import SwiftUI
import RickAndMortyGraphQLSchema

class URLSessionNetworkService {
    
    private let urlString = "https://rickandmortyapi.com/graphql"
                                                                 
    private func performGraphQLRequest(with requestBody:[String: Any]) async -> OperationResult<([String : Any])> {
        
        guard let url = URL(string: self.urlString) else {
            return .failed(nil)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(returning:.failed(error))
                    return
                }
                
                guard let data = data else {
                    continuation.resume(returning:.failed(nil))
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        continuation.resume(returning:.success(jsonResponse))
                        return
                    }
                } catch {

                }
                continuation.resume(returning:.failed(nil))
                return
            }
            
            task.resume()
        }
        
    }

}

extension URLSessionNetworkService: NetworkService {
    
    func fetchCharacter(with id: String) async -> OperationResult<СharacterModel> {
        guard let url = URL(string: self.urlString) else {
            return .failed(nil)
        }
        
        let query = """
        query Character($id: ID!) {
            character(id: $id) {
                id
                name
                status
                species
                type
                gender
                image
                episode {
                    id
                    name
                    episode
                }
                origin {
                    id
                    name
                }
                location {
                    id
                    name
                }
                created
            }
        }
        """
        
        let requestBody: [String: Any] = [
            "query": query,
            "variables": [
                "id": "\(id)",
            ]
        ]
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

        
        let result = await self.performGraphQLRequest(with: requestBody)
        
        switch result {
        case .success(let jsonResponse):
            if let data = jsonResponse["data"] as? [String: Any],
               let characterData = data["character"] as? [String: Any] {
                return .success(СharacterModel(data: characterData))
            }
        case .failed(let error):
            return .failed(error)
        }
        
        return .failed(nil)
    }
    
    func fetchCharacters(for page: Int, includePageInfo: Bool) async -> OperationResult<([СharacterRepresentation], Int?)> {
        let query = """
        query Characters($page: Int!, $includePageInfo: Boolean!) {
            characters(page: $page) {
                results {
                    id
                    name
                    image
                    status
                    gender
                }
                info @include(if: $includePageInfo) {
                    pages
                }
            }
        }
        """

        let requestBody: [String: Any] = [
            "query": query,
            "variables": [
                "page": page,
                "includePageInfo": includePageInfo
            ]
        ]
        
        let result = await self.performGraphQLRequest(with: requestBody)
        
        switch result {
        case .success(let jsonResponse):
            if let data = jsonResponse["data"] as? [String: Any],
               let charactersData = data["characters"] as? [String: Any],
               let results = charactersData["results"] as? [[String: Any]] {
                
                let characters = results.compactMap { data in
                    if let data = data as? [String: String] {
                        return СharacterRepresentation(data: data)
                    }
                    return nil
                }
                
                if includePageInfo, let info = charactersData["info"] as? [String: Int], let pagesCount = info["pages"] {
                    return .success((characters, pagesCount))
                } else {
                    return .success((characters, nil))
                }
            }
        case .failed(let error):
            return .failed(error)
        }
        
        return .failed(nil)
    }
    
    
}


