//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation
import SwiftUI
import Apollo
import RickAndMortyGraphQLSchema
import Dependencies

struct PageInfo {
    let count:Int?
    let pages:Int?
    let next:Int?
    let prev:Int?
}

/*
 "count": 826
 "pages": 42
 "next": 17
 "prev": 15
 */

enum FetchCharactersResult: Error {
    case success([СharacterRepresentation], Int?)
    case failed(String)
}

class NetworkManager {
    
    private let urlString = "https://rickandmortyapi.com/graphql"
    
    private var apollo:ApolloClient?
    
    init() {
        if let url = URL(string: urlString) {
            self.apollo = ApolloClient(url: url)
        }
    }
    
    func fetchCharacters(for page:Int, includePageInfo:Bool = false) async -> FetchCharactersResult {
        
        guard let apollo = self.apollo else {
            return .failed("No service")
        }
        
        return await withCheckedContinuation { continuation in
            apollo.fetch(query: CharactersQuery(page: page, includePageInfo: includePageInfo)) { result in
                switch result {
                case .success(let graphQLResult):
                    
                    if let results = graphQLResult.data?.characters?.results {
                        let characters = results.compactMap { result in
                            if let result = result {
                                return СharacterRepresentation(data: result)
                            } else {
                                return nil
                            }
                        }
                        
                        print("Success! Result: \(characters)")
                        continuation.resume(returning: .success(characters, graphQLResult.data?.characters?.info?.pages))
                    } else {
                        continuation.resume(returning: .success([], nil))
                    }
                    
                case .failure(let error):
                    continuation.resume(returning:.failed(error.localizedDescription))
                }
            }
        }
    }
    
    /*func fetchCharacters() async -> [СharacterRepresentation] {
        
        guard let apollo = self.apollo else {
            return []
        }
        
        return try await withCheckedThrowingContinuation { continuation in
            apollo.fetch(query: CharactersQuery()) { result in
                switch result {
                case .success(let graphQLResult):
                    continuation.resume(returning: graphQLResult)
                    //print("Success! Result: \(graphQLResult)")
                case .failure(let error):
                    continuation.resume(returning: data)
                    //print("Failure! Error: \(error)")
                }
            }
        }
        return []
    }*/
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
