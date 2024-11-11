//
//  Services.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 09.11.2024.
//

enum OperationResult<T> {
    case success(T)
    case failed(Error?)
}


protocol NetworkService {
    func fetchCharacter(with id:String) async -> OperationResult<СharacterModel>
    func fetchCharacters(for page:Int, includePageInfo:Bool) async -> OperationResult<([СharacterRepresentation], Int?)> 
}


protocol LocalStorage {
    func save(characters: [СharacterRepresentation]) async -> OperationResult<Void>
    func fetchCharacters() async -> OperationResult<[СharacterRepresentation]>
}

protocol RepositoryProtocol {
    func fetchCharacters(for page:Int, includePageInfo:Bool) async -> OperationResult<([СharacterRepresentation], Int?)>
    func fetchCharacter(with id:String) async -> OperationResult<СharacterModel>
}
