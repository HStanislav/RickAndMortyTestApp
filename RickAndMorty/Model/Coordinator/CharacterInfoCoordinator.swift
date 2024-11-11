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
    
    private let characterId:String
    
    init(with navigationController: UINavigationController, characterId:String) {
        self.navigationController = navigationController
        self.characterId = characterId
    }
    
    func coordinatorDidFinish() {
        
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
