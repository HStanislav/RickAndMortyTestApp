//
//  СharacterCell.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI

struct CharacterCell: View {
    
    let characterState:CharacterRepresentationState
    
    var body: some View {
        HStack {
            if let image = characterState.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
            
            Spacer()
            Text(characterState.characterRepresentation.name)
            Spacer()
        }
    }
}

#Preview {
    
    CharacterCell(characterState: CharacterRepresentationState(characterRepresentation: СharacterRepresentation(data: [:])))
}
