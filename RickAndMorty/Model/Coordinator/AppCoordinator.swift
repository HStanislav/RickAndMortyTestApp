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

    func start() {
        let coordinator = CharactersListCoordinator(with: self.navigationController)
        self.addChild(coordinator)
        coordinator.start()
    }
    
    
    var childCoordinators = [Coordinator]()
    
    var navigationController = UINavigationController()
    
}
