//
//  RealmLocalStorage.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 09.11.2024.
//

import RealmSwift

class CharacterRepresentationObject: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var imageURL: String = ""
    
    convenience init(character: СharacterRepresentation) {
        self.init()
        self.id = character.id
        self.name = character.name
        self.imageURL = character.imageURL
    }
}


class RealmLocalStorage {
    
    var realm:Realm? = nil
    
    init() {
        Task.detached { @MainActor in
            self.realm = try? Realm()
        }
    }
}

extension RealmLocalStorage: LocalStorage {
    
    @MainActor
    func save(characters: [СharacterRepresentation]) async -> OperationResult<Void> {
        
        guard let realm = self.realm else {
            return .failed(nil)
        }
        
        let realmObjects = characters.map { CharacterRepresentationObject(character: $0) }
        
        try? realm.write {
            realm.add(realmObjects, update: .modified)
        }
        
        
        return .success(())
    }
    
    @MainActor
    func fetchCharacters() async -> OperationResult<[СharacterRepresentation]> {
        
        guard let realm = self.realm else {
            return .failed(nil)
        }
        
        let realmObjects = realm.objects(CharacterRepresentationObject.self)
        let characters:[СharacterRepresentation] = realmObjects.map { СharacterRepresentation(data: ["id": $0.id, "name": $0.name, "image": $0.imageURL]) }
        return .success(characters)
    }
    
}
