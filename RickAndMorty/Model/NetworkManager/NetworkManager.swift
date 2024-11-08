//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation
import SwiftUI
import RickAndMortyGraphQLSchema
import Dependencies

struct PageInfo {
    let count:Int?
    let pages:Int?
    let next:Int?
    let prev:Int?
}

enum FetchCharactersResult: Error {
    case success([СharacterRepresentation], Int?)
    case failed(String?)
}

class NetworkManager {
    
    private let urlString = "https://rickandmortyapi.com/graphql"
    
    func fetchCharacters(for page:Int, includePageInfo:Bool = false) async -> FetchCharactersResult {
        
        
        guard let url = URL(string: urlString) else {
            return .failed(nil)
        }
        
        
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

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

        return await withCheckedContinuation { continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(returning:.failed(error.localizedDescription))
                    return
                }
                
                guard let data = data else {
                    continuation.resume(returning:.failed(nil))
                    return
                }
                
                do {
                    if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let data = jsonResponse["data"] as? [String: Any],
                           let characters = data["characters"] as? [String: Any],
                           let results = characters["results"] as? [[String: Any]] {
                            
                            let result = results.compactMap { data in
                                if let data = data as? [String: String] {
                                    return СharacterRepresentation(data: data)
                                }
                                return nil
                            }
                            
                            if includePageInfo, let info = characters["info"] as? [String: Any] {
                                continuation.resume(returning: .success(result, nil))
                                return
                            }
                            continuation.resume(returning: .success(result, nil))
                        }
                        
                    }
                } catch {
                    continuation.resume(returning:.failed(nil))
                    return
                }
            }
            
            task.resume()
        }
    }

}

extension NetworkManager: DependencyKey {
    static let liveValue = NetworkManager()
}


extension DependencyValues {
    
  var networkManager: NetworkManager {
    get { self[NetworkManager.self] }
    set { self[NetworkManager.self] = newValue }
  }
    
}
