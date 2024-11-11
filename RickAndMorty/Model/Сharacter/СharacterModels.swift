//
//  Сharacter.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//
import UIKit
import RickAndMortyGraphQLSchema


struct СharacterRepresentation: Equatable, Identifiable {
    
    let id: String
    
    var name: String
    
    let imageURL: String
    
    init(data: [String : String]) {
        self.id = data["id"] ?? ""
        self.imageURL = data["image"] ?? ""
        self.name = data["name"] ?? ""
    }
    
}



struct Episode: Equatable, Identifiable {
    
    let id: String

    let name: String
   
    let episode: String
    
    init(data: [String : String]) {
        self.id = data["id"] ?? ""
        self.name = data["name"] ?? ""
        self.episode = data["episode"] ?? ""
    }
}

struct Location: Equatable, Identifiable {
    let id: String
    let name: String
    
    init(data: [String : String]) {
        self.id = data["id"] ?? ""
        self.name = data["name"] ?? ""
    }
    
}


struct СharacterModel: Equatable, Identifiable {
    
    let id: String

    let name: String

    let status: String
 
    let species: String
   
    let type: String

    let gender: String
    
    let image: String
 
    let origin: Location

    let location: Location

    let episode: [Episode]
    
    let created: String
    
    init(data: [String : Any]) {
        self.id = data["id"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.status = data["status"] as? String ?? ""
        self.species = data["species"] as? String ?? ""
        self.type = data["type"] as? String ?? ""
        self.gender = data["gender"] as? String ?? ""

        self.image = data["image"] as? String ?? ""
        self.created = data["created"] as? String ?? ""
        let originData = data["origin"] as? [String : String] ?? [:]
        self.origin = Location(data: originData)
        
        let locationData = data["origin"] as? [String : String] ?? [:]
        self.location = Location(data:locationData)
        
        let episodeData = data["episode"] as? [[String : String]] ?? [[:]]
        self.episode = episodeData.map { Episode(data: $0) }
    }
    
}
