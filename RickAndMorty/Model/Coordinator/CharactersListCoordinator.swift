//
//  CharactersListCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class CharactersListCoordinator: ChildCoordinator {
    
    var viewController: UIViewController?
    var navigationController: UINavigationController
        
    init(with navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func coordinatorDidFinish() {
        
    }
    
    func start() {
        let store = Store(initialState: СharactersListFeature.State()) {
            СharactersListFeature(coordinator: self)
        }
        let view = CharactersListView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.viewController = viewController
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func showCharacteInfo(for charactetId:String) {
        let coordinator = CharacterInfoCoordinator(with: self.navigationController, characterId: charactetId)
        coordinator.start()
    }
}
