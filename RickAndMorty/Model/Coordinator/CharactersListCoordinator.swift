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
        let store = Store(initialState: СharactersListFeature.State()) {
            СharactersListFeature(coordinator: self)
        }
        let view = CharactersListView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func showCharacteInfo(for charactetId:String) {
        let coordinator = CharacterInfoCoordinator(with: self.navigationController, characterId: charactetId)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
}
