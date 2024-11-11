//
//  CharacterInfoFeature.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import ComposableArchitecture

struct CharacterModelState: Equatable, Identifiable {
    
    let charactedModel:СharacterModel
    
    var id: String {
        return charactedModel.id
    }
    var image: UIImage?
    
}

@Reducer
struct CharacterInfoFeature {
    @ObservableState
    struct State {
        var characterId:String
        var characterState:CharacterModelState?
        var isLoading: Bool = false
    }
    
    enum Action {
        case start
        case sendResponse(OperationResult<СharacterModel>)
        case imageLoaded(image: UIImage?)
        case navigateBack
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
                    state.characterState = CharacterModelState(charactedModel: characterModel)
                    return .run { send in
                        let image = await imageLoader.loadImage(from: characterModel.image)
                        await send(.imageLoaded(image: image))
                    }
                case .failed(_):
                    break
                }
            case .imageLoaded(image: let image):
                if let image = image {
                    state.characterState?.image = image
                }
            case .navigateBack:
                self.coordinator?.coordinatorDidFinish()
            }
            return .none
        }
    }
}
