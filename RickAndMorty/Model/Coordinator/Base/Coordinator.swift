//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    
    func start()
    var navigationController: UINavigationController { get set }
    func popViewController(animated: Bool)
}

extension Coordinator {
    
    func popViewController(animated: Bool) {
        self.navigationController.popViewController(animated: animated)
    }
    
}

protocol ParentCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] { get set }
    func addChild(_ child: Coordinator)
    func childDidFinish(_ child: Coordinator)
}

extension ParentCoordinator {
    
    func addChild(_ child: Coordinator){
        childCoordinators.append(child)
    }
    
    func childDidFinish(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

protocol ChildCoordinator: Coordinator {
    
    func coordinatorDidFinish()
    var viewController: UIViewController? { get set }
}
