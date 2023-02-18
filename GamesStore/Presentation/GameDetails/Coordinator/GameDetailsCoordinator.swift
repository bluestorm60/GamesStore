//
//  GameDetailsCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import UIKit

protocol GameDetailsBaseCoordinator: MainCoordinator {
    var game: Game {get}
}
final class GamesDetailsCoordinator: GameDetailsBaseCoordinator{
    var game: Game
    
    var navigationController: UINavigationController?
    var rootViewController: UIViewController?
    
    init(navigationController: UINavigationController, game: Game){
        self.game = game
        self.navigationController = navigationController
    }
    
    func start() {
        let container = AppDIContainer()
        let repo = DefaultGameDetailsRepository(dataTransferService: container.apiDataTransferService, cache: CoreDataFavouriteGamesResponseStorage())
        let useCase = DefaultGameDetailsUseCase(gamesRepository: repo)
        let viewModel = DefaultGameDetailsViewModel(gameDetailsUseCase: useCase, game: game, coordinator: self)
        rootViewController = GameDetailsViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(rootViewController!, animated: true)
    }
    
}
