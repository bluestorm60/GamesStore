//
//  FavouriteListCoordinator.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

final class GamesFavouriteCoordinator: GameBaseCoordinator{
    var navigationController: UINavigationController?
    
    var rootViewController: UIViewController?
    
    func start() {
        let repo = DefaultFavouriteGamesRepository(cache: CoreDataFavouriteGamesResponseStorage())
        let useCase = DefaultFavouriteGamesUseCase(favouriteRepo: repo)
        let viewModel = DefaultFavouriteListViewModel(coordinator: self, useCase: useCase)
        rootViewController = FavViewController(viewModel: viewModel)

        navigationController = UINavigationController(rootViewController: rootViewController!)
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true


    }
    
    func openDetails(game: Game) {
        guard let navigationController = navigationController else {return}
        GamesDetailsCoordinator(navigationController: navigationController, game: game).start()
    }
    
}
