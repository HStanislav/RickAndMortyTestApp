//
//  RealmLocalStorage.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 09.11.2024.
//

class RealmLocalStorage {
    
}

extension RealmLocalStorage: LocalStorage {
    
    func save(characters: [СharacterRepresentation]) -> OperationResult<Void> {
        return .failed(nil)
    }
    
}
