//
//  CharacterInfoFeature.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import ComposableArchitecture

/*struct CharacterState: Equatable, Identifiable {
    
    let id: String

    let name: String

    let status: String
 
    let species: String
   
    let type: String

    let gender: String
    
    let imageURL: String
    
    var image: UIImage
 
    let origin: Location

    let location: Location

    let episode: [Episode]
    
    let created: String
    
}*/

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
    
    @Dependency(\.repository) var repository
    @Dependency(\.imageLoader) var imageLoader
    
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
                    let result = await self.repository.fetchCharacter(with: characterId)
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
