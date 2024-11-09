//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 07.11.2024.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
    let appCoordinator = AppCoordinator()
    
    var body: some View {
        NavigationControllerView(coordinator: appCoordinator)
            .onAppear {
                appCoordinator.start()
            }
    }
}

#Preview {
    ContentView()
}
