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
        var characters: IdentifiedArrayOf<СharacterRepresentation> = []
        var isLoading: Bool = false
        var nextPage = 1
        var totalPages:Int? = nil
    }
    
    enum Action {
        case start
        case sendResponse(FetchCharactersResult)
        case onAppear(СharacterRepresentation)
        case didScrollToBottom
    }
    
    @Dependency(\.networkManager) var networkManager
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .start, .didScrollToBottom:
                state.isLoading = true
                let currentPage = state.nextPage
                if let totalPages = state.totalPages, state.nextPage > totalPages {
                    return .none
                }
                let includePageInfo = state.totalPages == nil
                return .run { send in
                    let result = await self.networkManager.fetchCharacters(for: currentPage, includePageInfo: includePageInfo)
                    await send(.sendResponse(result))
                }
            case .sendResponse(let result):
                state.isLoading = false
                switch result {
                case .success(let characters, let pagesCount):
                    if state.totalPages == nil {
                        state.totalPages = pagesCount
                    }
                    state.characters.append(contentsOf: characters)
                    state.nextPage += 1
                default:
                    break
                }
            case .onAppear(let character):
                if character == state.characters.last {
                    return .run { send in
                        await send(.didScrollToBottom)
                    }
                }                
            }
            return .none
        }
    }
}
