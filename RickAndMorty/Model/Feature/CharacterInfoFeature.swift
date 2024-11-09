//
//  CharacterInfoFeature.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import Foundation
import ComposableArchitecture

@Reducer
struct CharacterInfoFeature {
    @ObservableState
    struct State {
        var id:String = ""
        var isLoading: Bool = false
    }
    
    enum Action {
        case start
        case sendResponse
    }
    
    @Dependency(\.networkManager) var networkManager
    
    private let coordinator: CharacterInfoCoordinator
    
    init(coordinator: CharacterInfoCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .start:
                break
            case .sendResponse:
                break
            }
            return .none
        }
    }
}
