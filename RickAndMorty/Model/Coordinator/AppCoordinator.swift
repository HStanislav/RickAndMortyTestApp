//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class AppCoordinator: ParentCoordinator {

    var childCoordinators = [Coordinator]()
    var navigationController = UINavigationController()
    
    func start() {
        let coordinator = CharactersListCoordinator(with: self.navigationController, parent: self)
        self.addChild(coordinator)
        coordinator.start()
    }
    
    func showCharacteInfo(for charactetId:String) {
        let coordinator = CharacterInfoCoordinator(with: self.navigationController, parent: self, characterId: charactetId)
        self.addChild(coordinator)
        coordinator.start()
    }
    
}
