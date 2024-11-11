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
    
}

extension Repository: RepositoryProtocol {
    func fetchCharacters(for page:Int, includePageInfo:Bool) async -> OperationResult<([СharacterRepresentation], Int?)> {
        let result = await self.networkService.fetchCharacters(for: page, includePageInfo: includePageInfo)
        switch result {
        case .success((let characters, _)):
            Task {
                _ = await self.localStorage.save(characters: characters)
            }
        default:
            break
        }
        return result
    }
    
    func fetchCharacter(with id:String) async -> OperationResult<СharacterModel> {
        return await self.networkService.fetchCharacter(with: id)
    }
}



enum RepositoryKey: DependencyKey {
    static let liveValue:RepositoryProtocol = Repository(
        networkService: URLSessionNetworkService(),
        localStorage: RealmLocalStorage()
    )
}


extension DependencyValues {
    
  var repository: RepositoryProtocol {
    get { self[RepositoryKey.self] }
    set { self[RepositoryKey.self] = newValue }
  }
    
}
