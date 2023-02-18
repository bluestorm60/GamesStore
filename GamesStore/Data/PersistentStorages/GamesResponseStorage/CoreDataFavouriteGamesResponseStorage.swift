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
    
    private func fetchRequest(for requestDto: GamesResponseDTO.GameDTO) -> NSFetchRequest<GameFavouritesEntity> {
        let request: NSFetchRequest = GameFavouritesEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@",
                                        requestDto.id as NSNumber)
        return request
    }
    
    private func deleteResponse(response: GamesResponseDTO.GameDTO, in context: NSManagedObjectContext, completion: ((Error?) -> Void)? = nil) {
        let request = fetchRequest(for: response)
        
        do {
            let result = try context.fetch(request)
            for item in result{
                context.delete(item)
            }
            try context.save()
            completion?(nil)
        } catch {
            completion?(error)
            print(error)
        }
    }
    
    
}
extension CoreDataFavouriteGamesResponseStorage: GamesFavouriteStorage{
    
    
    func isFavourited(game: GamesResponseDTO.GameDTO, cached: @escaping (Bool) -> Void) {
        coreDataStorage.performBackgroundTask { context in
            do {
                let fetchRequest = self.fetchRequest(for: game)
                let requestEntity = try context.fetch(fetchRequest).first
                if let id =  requestEntity?.id, id == game.id{
                    cached(true)
                }else{
                    cached(false)
                }
            } catch {
                cached(false)
            }
        }
        
    }
    
    
    func delete(response: GamesResponseDTO.GameDTO,completion: ((Error?) -> Void)? = nil) {
        coreDataStorage.performBackgroundTask { context in
            self.deleteResponse(response: response, in: context,completion: completion)
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
    
    
    func save(response: GamesResponseDTO.GameDTO, completion: ((Error?) -> Void)? = nil) {
        coreDataStorage.performBackgroundTask { context in
            do {
                self.deleteResponse(response: response, in: context)
                
                _ = response.toEntityFavourite(in: context)
                
                try context.save()
                completion?(nil)
            } catch {
                // TODO: - Log to Crashlytics
                debugPrint("CoreDataGamesResponseStorage Unresolved error \(error), \((error as NSError).userInfo)")
                completion?(error)
            }
        }
    }
    
    
}
