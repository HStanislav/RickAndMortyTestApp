//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        CharactersListView(
            store: Store(
                initialState:СharactersListFeature.State(),
                reducer: {
                    СharactersListFeature()
                }
            ))
    }
}

#Preview {
    ContentView()
}
