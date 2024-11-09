//
//  CharactersListCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class CharactersListCoordinator: BaseCoordinator {
    
    private let navigationController: UINavigationController
    
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    override func start() {
        let characterInfoCoordinator = CharacterInfoCoordinator(with: self.navigationController)
        
        let store = Store(initialState: CharacterInfoFeature.State()) {
            CharacterInfoFeature(coordinator: characterInfoCoordinator)
        }
        let view = CharacterInfoView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: true)
    }
}
