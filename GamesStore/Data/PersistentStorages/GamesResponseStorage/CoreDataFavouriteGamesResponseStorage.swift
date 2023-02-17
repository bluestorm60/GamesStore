//
//  CoreDataFavouriteGamesResponseStorage.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 17/02/2023.
//

import Foundation
import CoreData

final class CoreDataFavouriteGamesResponseStorage {
    private let coreDataStorage: CoreDataStorage
    init(coreDataStorage: CoreDataStorage = CoreDataStorage.shared) {
        self.coreDataStorage = coreDataStorage
    }
    // MARK: - Private
    
    private func fetchRequest() -> NSFetchRequest<GameFavouritesEntity> {
        let request: NSFetchRequest = GameFavouritesEntity.fetchRequest()
        return request
    }
    
    private func deleteResponse(response: GamesResponseDTO.GameDTO, in context: NSManagedObjectContext) {
        let request = fetchRequest()
        
        do {
            if let result = try context.fetch(request).first {
                context.delete(result)
            }
        } catch {
            print(error)
        }
    }
    
    
}
extension CoreDataFavouriteGamesResponseStorage: GamesFavouriteStorage{
    func delete(response: GamesResponseDTO.GameDTO) {
        coreDataStorage.performBackgroundTask { context in
            self.deleteResponse(response: response, in: context)
        }
    }
    
    func getFavourites(completion: @escaping (Result<[GamesResponseDTO.GameDTO]?, CoreDataStorageError>) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest()
                let requestEntity = try context.fetch(fetchRequest)
                
                completion(.success(requestEntity.map({ $0.toDTO()})))
            } catch {
                completion(.failure(CoreDataStorageError.readError(error)))
            }
        }
        
    }
    
    
    func save(response: GamesResponseDTO.GameDTO) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(response: response, in: context)
                
                _ = response.toEntityFavourite(in: context)
                
                try context.save()
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataMoviesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
            }
        }
    }
    
    
}
