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
                    .frame(height: 80)
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }
            
            Spacer()
            Text(characterState.characterRepresentation.name)
            Spacer()
        }
        .navigationBarTitle(Text("Characters")) 
    }
}

#Preview {
    CharacterCell(characterState: CharacterRepresentationState(characterRepresentation: СharacterRepresentation(data: [:])))
}
