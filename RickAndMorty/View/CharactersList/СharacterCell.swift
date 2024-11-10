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
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                ProgressView()
            }
            
            Spacer()
            Text(character.name)
            Spacer()
        }
    }
}

#Preview {
    
    CharacterCell(character: CharacterRepresentationState(id: "id", name: "name", imageURL: ""))
}
