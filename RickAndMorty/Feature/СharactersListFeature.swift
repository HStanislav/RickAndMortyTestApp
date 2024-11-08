//
//  СharactersListFeature.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import Foundation
import ComposableArchitecture


@Reducer
struct СharactersListFeature {
    @ObservableState
    struct State {
        var contacts: IdentifiedArrayOf<СharacterRepresentation> = []
        var isLoading: Bool = false
    }
    
    enum Action {
        case loadCharacters
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .loadCharacters:
                state.isLoading = true
                break
            }
            return .none
        }
    }
}
