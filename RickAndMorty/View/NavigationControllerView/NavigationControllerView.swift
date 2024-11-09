//
//  NavigationControllerView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 08.11.2024.
//

import SwiftUI


struct NavigationControllerView: UIViewControllerRepresentable {
    
    let coordinator:AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }

    func makeUIViewController(context: Context) -> UINavigationController {
        return coordinator.navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
     
    }
}
