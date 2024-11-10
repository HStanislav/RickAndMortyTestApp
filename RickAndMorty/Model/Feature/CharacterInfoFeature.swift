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
        var characterId:String
        var character:СharacterModel?
        var isLoading: Bool = false
    }
    
    enum Action {
        case start
        case sendResponse(OperationResult<СharacterModel>)
    }
    
    @Dependency(\.networkManager) var networkManager
    
    private var coordinator: CharacterInfoCoordinator?
    
    init(coordinator: CharacterInfoCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .start:
                guard state.isLoading == false else {
                    return .none
                }
                let characterId = state.characterId
                state.isLoading = true
                return .run { send in
                    let result = await self.networkManager.fetchCharacter(with: characterId)
                    await send(.sendResponse(result))
                }
            case .sendResponse(let result):
                state.isLoading = false
                switch result {
                case .success(let characterModel):
                    state.character = characterModel
                case .failed(_):
                    break
                }
            }
            return .none
        }
    }
}
