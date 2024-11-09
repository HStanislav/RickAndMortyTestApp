//
//  CharacterInfoView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharacterInfoView: View {
    
    var store: StoreOf<CharacterInfoFeature>
    
    var body: some View {
        VStack {
            if let character = store.character {
                HStack {
                    Text("name : ")
                    Text(character.name)
                }
                
                HStack {
                    Text("gender : ")
                    Text(character.gender)
                }
                
                HStack {
                    Text("species : ")
                    Text(character.species)
                }
                
                HStack {
                    Text("status : ")
                    Text(character.status)
                }
                
                HStack {
                    Text("type : ")
                    Text(character.type)
                }
            }
            
        }
        .onAppear {
            store.send(.start)
        }
    }
}

#Preview {
    CharacterInfoView(
        store: Store(
            initialState:CharacterInfoFeature.State(
                characterId: ""
            ),
            reducer: {
                CharacterInfoFeature(
                    coordinator: CharacterInfoCoordinator(
                        with: UINavigationController(),
                        characterId: ""
                    )
                )
            }
        ))
}
