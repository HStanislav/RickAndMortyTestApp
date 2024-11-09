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
        Text("")
    }
}

#Preview {
    CharacterInfoView(
        store: Store(
            initialState:CharacterInfoFeature.State(),
            reducer: {
                CharacterInfoFeature(
                    coordinator: CharacterInfoCoordinator(
                        with: UINavigationController()
                    )
                )
            }
        ))
}
