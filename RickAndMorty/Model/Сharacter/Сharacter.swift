//
//  Сharacter.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//
import Foundation
import RickAndMortyGraphQLSchema


struct СharacterRepresentation: Equatable, Identifiable {
    
    let id: String?
    var name: String?
    var gender: String?
    let status: String?
    
    init(data: CharactersQuery.Data.Characters.Result) {
        self.id = data.id
        self.name = data.name
        self.gender = data.gender
        self.status = data.status
    }
    
}


struct Сharacter: Equatable, Identifiable {
    let id: UUID

    let name: String

    let status: String
 
    let species: String
   
    let type: String

    let gender: String
 
    let origin: String

    let location: String

    let image: String

    let episode: [Episode]!
    
    let created: String
}
