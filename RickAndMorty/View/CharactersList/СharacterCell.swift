//
//  СharacterCell.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI

struct CharacterCell: View {
    
    let character:CharacterRepresentationState
    
    var body: some View {
        HStack {
            if let image = character.image {
                Image(uiImage: image)
            }
            Text(character.name)
        }
    }
}
