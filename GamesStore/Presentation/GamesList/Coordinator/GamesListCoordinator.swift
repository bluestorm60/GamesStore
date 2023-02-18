//
//  GamesListCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

protocol GameBaseCoordinator: MainCoordinator {
    func openDetails(game: Game)
}

final class GameListCoordinator: GameBaseCoordinator{
    var navigationController: UINavigationController?
    
    var rootViewController: UIViewController?
    
    func start() {
        let container = AppDIContainer()
        let cache = CoreDataGamesResponseStorage()
        let repo = DefaultGamesRepository(dataTransferService: container.apiDataTransferService, cache: cache)
        let useCase = DefaultSearchGamesUseCase(gamesRepository: repo)
        let viewModel = DefaultGamesListViewModel(searchGamesUseCase: useCase, coordinator: self)
        rootViewController = GamesListViewController(viewModel: viewModel)

        navigationController = UINavigationController(rootViewController: rootViewController!)
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    func openDetails(game: Game) {
        guard let navigationController = navigationController else {return}
        GamesDetailsCoordinator(navigationController: navigationController, game: game).start()
    }
    
}
