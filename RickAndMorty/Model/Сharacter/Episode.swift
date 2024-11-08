//
//  Episode.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation 

struct Episode: Equatable, Identifiable {
    
    let id: String

    let name: String
   
    let air_date: String

    let episode: String
    
    let characters: [Character]!
 
    let created: String

    
}
