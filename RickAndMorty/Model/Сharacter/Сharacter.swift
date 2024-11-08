//
//  Сharacter.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//
import Foundation


struct СharacterRepresentation: Equatable, Identifiable {
    
  let id: UUID
  var name: String
  let gender: String
  let status: String
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
