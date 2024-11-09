//
//  СharacterCell.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI

struct CharacterCell: View {
    
    let character:СharacterRepresentation
    
    var body: some View {
        HStack {
            Text(character.name)
            Text(character.status)
            Text(character.gender)
        }
        
    }
}
