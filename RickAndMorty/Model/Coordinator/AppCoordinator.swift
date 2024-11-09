//
//  AppCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class AppCoordinator: BaseCoordinator {
    
    let navigationController = UINavigationController()
    
    override func start() {
        let coordinator = CharactersListCoordinator(with: self.navigationController)
        self.childCoordinators.append(coordinator)
        coordinator.start()
    }
    
}
