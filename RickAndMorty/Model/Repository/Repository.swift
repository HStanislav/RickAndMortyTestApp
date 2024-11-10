//
//  Repository.swift
//  RickAndMorty
//
//  Created by Стас Гринорьев on 09.11.2024.
//

import Dependencies

class Repository {
    
    private let networkService: NetworkService
    private let localStorage: LocalStorage
        
    init(networkService: NetworkService, localStorage: LocalStorage) {
        self.networkService = networkService
        self.localStorage = localStorage
    }
    
    func fetchCharacters(for page:Int, includePageInfo:Bool) async -> OperationResult<([СharacterRepresentation], Int?)> {
        return await self.networkService.fetchCharacters(for: page, includePageInfo: includePageInfo)
    }
    
    func fetchCharacter(with id:String) async -> OperationResult<СharacterModel> {
        return await self.networkService.fetchCharacter(with: id)
    }
    
}



extension Repository: DependencyKey {
    static let liveValue = Repository(
        networkService: URLSessionNetworkService(),
        localStorage: RealmLocalStorage()
    )
}


extension DependencyValues {
    
  var repository: Repository {
    get { self[Repository.self] }
    set { self[Repository.self] = newValue }
  }
    
}
