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
    @Environment(\.isPresented) var isPresented
    
    var body: some View {
        WithPerceptionTracking {
            VStack() {
                if let characterState = store.characterState {
                    
                    if let image = characterState.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 300)
                    } else {
                        ProgressView()
                            .frame(width: 300, height: 300)
                    }
                    
                    
                    let columns = [
                        GridItem(.fixed(200), alignment: .trailing),
                        GridItem(.fixed(200), alignment: .leading)
                    ]
                    
                    LazyVGrid(columns: columns, alignment: .center, spacing: 8) {
                        Text("name : ")
                        Text(characterState.charactedModel.name)
                        Text("gender : ")
                        Text(characterState.charactedModel.gender)
                        Text("species : ")
                        Text(characterState.charactedModel.species)
                        Text("status : ")
                        Text(characterState.charactedModel.status)
                        Text("type : ")
                        Text(characterState.charactedModel.type)
                        Text("origin : ")
                        Text(characterState.charactedModel.origin.name)
                        Text("location : ")
                        Text(characterState.charactedModel.location.name)
                    }
                    .frame(width: 400)
                    
                    Spacer(minLength: 50)
                    
                    HStack {
                        Spacer()
                        
                        Text("EPISODE")
                        
                        Spacer()
                    }
                    List(characterState.charactedModel.episode) { episode in
                        LazyVStack {
                            EpisodeCell(episode: episode)
                        }
                    }
                    
                }
                
            }
            .onAppear {
                store.send(.start)
            }
            .onDisappear {
                if isPresented == false {
                    store.send(.navigateBack)
                }
            }
        }
    }
}

#Preview {
    CharacterInfoView(
        store: Store(
            initialState:CharacterInfoFeature.State(
                characterId: ""
            ),
            reducer: {
                CharacterInfoFeature(
                    coordinator: CharacterInfoCoordinator(
                        with: UINavigationController(),
                        parent: AppCoordinator(),
                        characterId: ""
                    )
                )
            }
        ))
}
