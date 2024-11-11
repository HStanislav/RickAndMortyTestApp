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
            
            List(store.characters) { character in
                LazyVStack {
                    CharacterCell(characterState: character)
                        .frame(height: 90)
                        .onTapGesture {
                            store.send(.characterButtonTapped(character))
                        }
                        .onAppear {
                            store.send(.onAppear(character.id))
                        }
                        .onDisappear() {
                            store.send(.onDisappear(character.id))
                        }
                    
                }
            }
            .onAppear {
                store.send(.start)
            }
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
