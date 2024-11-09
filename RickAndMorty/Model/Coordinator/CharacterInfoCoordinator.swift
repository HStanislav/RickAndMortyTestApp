//
//  CharacterInfoViewCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class CharacterInfoCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    private let characterId:String
    
    init(with navigationController: UINavigationController, characterId:String) {
        self.navigationController = navigationController
        self.characterId = characterId
    }
    
    override func start() {
        let store = Store(initialState: CharacterInfoFeature.State(characterId: self.characterId)) {
            CharacterInfoFeature(coordinator: self)
        }
        let view = CharacterInfoView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
