//
//  GamesResponseEntity+Mapping.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 15/02/2023.
//

import Foundation
import CoreData

extension GamesResponseEntity {
    func toDTO() -> GamesResponseDTO {
        return .init(nextPage: nextPage,count: Int(count), games: games?.allObjects.map {($0 as! GameResponseEntity).toDTO() } ?? [])
    }
}

extension GameFavouritesEntity {
    func toDTO() -> GamesResponseDTO.GameDTO {
        let gernes = genres?.components(separatedBy: ",").map({GamesResponseDTO.GameDTO.GenerDTO(name: $0)})
        return .init(id: Int(id), name: title, genres: gernes ?? [], metaCritic: Int(metaCritic), backgroundImage: backgroundImage)
    }
}
extension GameResponseEntity {
    func toDTO() -> GamesResponseDTO.GameDTO {
        let gernes = genres?.components(separatedBy: ",").map({GamesResponseDTO.GameDTO.GenerDTO(name: $0)})
        return .init(id: Int(id), name: title, genres: gernes ?? [], metaCritic: Int(metaCritic), backgroundImage: backgroundImage)
    }
}

extension GamesRequestDTO {
    func toEntity(in context: NSManagedObjectContext) -> GamesRequestEntity {
        let entity: GamesRequestEntity = .init(context: context)
        entity.query = query
        entity.page = Int32(page)
        entity.pageSize = Int32(pageSize)
        return entity
    }
}

extension GamesResponseDTO {
    func toEntity(in context: NSManagedObjectContext) -> GamesResponseEntity {
        let entity: GamesResponseEntity = .init(context: context)
        entity.nextPage = nextPage
        entity.count = Int64(count)
        games.forEach {
            entity.addToGames($0.toEntity(in: context))
        }
        return entity
    }
}

extension GamesResponseDTO.GameDTO {
    func toEntity(in context: NSManagedObjectContext) -> GameResponseEntity {
        let entity: GameResponseEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = name
        entity.backgroundImage = backgroundImage
        if let metaCritic = metaCritic {
            entity.metaCritic = Int32(metaCritic)
        }
        entity.genres = genres.map({$0.name}).joined(separator: ",")
        return entity
    }
    
    func toEntityFavourite(in context: NSManagedObjectContext) -> GameFavouritesEntity{
        let entity: GameFavouritesEntity = .init(context: context)
        entity.id = Int64(id)
        entity.title = name
        entity.backgroundImage = backgroundImage
        if let metaCritic = metaCritic {
            entity.metaCritic = Int32(metaCritic)
        }
        entity.genres = genres.map({$0.name}).joined(separator: ",")
        return entity
    }
}
