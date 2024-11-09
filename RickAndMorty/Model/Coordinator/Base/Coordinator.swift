//
//  Coordinator.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//


protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
}

extension Coordinator {
    
    func add(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
    
}
