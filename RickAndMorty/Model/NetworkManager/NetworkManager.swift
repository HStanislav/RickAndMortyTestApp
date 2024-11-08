//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation
import Apollo
import RickAndMortyGraphQLSchema

class NetworkManager {
    
    private let urlString = "https://rickandmortyapi.com/graphql"
    
    private var apollo:ApolloClient?
    
    init() {
        if let url = URL(string: urlString) {
            self.apollo = ApolloClient(url: url)
        }
    }
    
    func fetch() -> [Int] {
        
        guard let apollo = self.apollo else {
            return []
        }
        
        apollo.fetch(query: CharactersQuery()) { result in
               switch result {
               case .success(let graphQLResult):
                   print("Success! Result: \(graphQLResult)")
               case .failure(let error):
                   print("Failure! Error: \(error)")
               }
           }
        return []
    }
}
