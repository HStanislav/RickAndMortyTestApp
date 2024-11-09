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
        let charactersListCoordinator = CharactersListCoordinator(with: self.navigationController)
        let store = Store(initialState: СharactersListFeature.State()) {
            СharactersListFeature(coordinator: charactersListCoordinator)
        }
        let view = CharactersListView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
}
