//
//  CharacterInfoViewCoordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit
import SwiftUI
import ComposableArchitecture

class CharacterInfoCoordinator: ChildCoordinator {
    
    var navigationController: UINavigationController
    var viewController: UIViewController?
    weak var parent: AppCoordinator?
    
    private let characterId:String
    
    init(with navigationController: UINavigationController, parent: AppCoordinator, characterId:String) {
        self.navigationController = navigationController
        self.parent = parent
        self.characterId = characterId
    }
    
    func coordinatorDidFinish() {
        self.parent?.childDidFinish(self)
        self.popViewController(animated: false)
    }
    
    func start() {
        let store = Store(initialState: CharacterInfoFeature.State(characterId: self.characterId)) {
            CharacterInfoFeature(coordinator: self)
        }
        let view = CharacterInfoView(store: store)
        let viewController = UIHostingController(rootView: view)
        self.viewController = viewController
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
}
