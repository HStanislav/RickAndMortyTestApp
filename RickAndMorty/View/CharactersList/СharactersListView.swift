//
//  СharactersListView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct CharactersListView: View {
    
    var store: StoreOf<СharactersListFeature>
    
    var body: some View {
        WithPerceptionTracking {
            List {
                ForEach(store.characters) { character in
                    CharacterCell(character: character)
                        .onTapGesture {
                            store.send(.characterButtonTapped(character))
                        }
                        .onAppear {
                            store.send(.onAppear(character))
                        }
                        
                }
            }
        }
        .onAppear {
            store.send(.start)
        }
    }
}

#Preview {
    CharactersListView(
        store: Store(
            initialState:СharactersListFeature.State(),
            reducer: {
                СharactersListFeature(
                    coordinator: CharactersListCoordinator(
                        with: UINavigationController()
                    )
                )
            }
        ))
}
