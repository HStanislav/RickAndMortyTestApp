//
//  СharactersListFeature.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

struct CharacterRepresentationState: Equatable, Identifiable {
    
    let characterRepresentation: СharacterRepresentation
    var id:String {
        return characterRepresentation.id
    }
    var image: UIImage?
}

@Reducer
struct СharactersListFeature {
    @ObservableState
    struct State {
        var characters: IdentifiedArrayOf<CharacterRepresentationState> = []
        var isLoading: Bool = false
        var nextPage = 1
        var totalPages:Int? = nil
    }
    
    enum Action {
        case start
        case characterButtonTapped(CharacterRepresentationState)
        case didScrollToBottom
        
        case onDisappear(String)
        case onAppear(String)
        
        case sendResponse(OperationResult<([СharacterRepresentation], Int?)>)
        case imageLoaded(id: String, image: UIImage?)
    }
    
    @Dependency(\.repository) var repository
    @Dependency(\.imageLoader) var imageLoader
    
    
    private weak var coordinator: CharactersListCoordinator?
    
    init(coordinator: CharactersListCoordinator) {
        self.coordinator = coordinator
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .start, .didScrollToBottom:
                guard state.isLoading == false else {
                    return .none
                }
                state.isLoading = true
                let currentPage = state.nextPage
                if let totalPages = state.totalPages, state.nextPage > totalPages {
                    return .none
                }
                let includePageInfo = state.totalPages == nil
                return .run { send in
                    let result = await self.repository.fetchCharacters(for: currentPage, includePageInfo: includePageInfo)
                    await send(.sendResponse(result))
                }
            case .sendResponse(let result):
                state.isLoading = false
                switch result {
                case .success((let characters, let pagesCount)):
                    if state.totalPages == nil {
                        state.totalPages = pagesCount
                    }
                    let charactersStates = characters.map { CharacterRepresentationState(characterRepresentation: $0, image: nil) }
                    state.characters.append(contentsOf: charactersStates)
                    state.nextPage += 1
                default:
                    break
                }
            case .onDisappear(let id):
                if let index = state.characters.firstIndex(where: { $0.id == id }) {
                    state.characters[index].image = nil
                }
            case .onAppear(let id):

                guard let character = state.characters.first(where: { $0.id == id }) else {
                    return .none
                }
                let didScrollToBottom = character == state.characters.last

                return .run { send in
                    if didScrollToBottom {
                        await send(.didScrollToBottom)
                    }
                    let image = await imageLoader.loadImage(from: character.characterRepresentation.imageURL)
                    await send(.imageLoaded(id: id, image: image))
                }
            case .characterButtonTapped(let character):
                self.coordinator?.showCharacteInfo(for: character.id)
            case .imageLoaded(id: let id, image: let image):
                if let index = state.characters.firstIndex(where: { $0.id == id }) {
                    state.characters[index].image = image
                }
            }
            return .none
        }
    }
}
