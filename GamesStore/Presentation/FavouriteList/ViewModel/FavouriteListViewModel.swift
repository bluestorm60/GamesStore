//
//  FavouriteListViewModel.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation
protocol FavouriteListViewModelOutput{
    var items: Observable<[GamesListItemViewModel]> { get }
}
protocol FavouriteListViewModelInput{
    func viewDidload()
    func viewWillAppear()
    func deleteItem(indexPath: Int)
    func didSelect(indexPath: Int)
}
protocol FavouriteListViewModel: FavouriteListViewModelInput, FavouriteListViewModelOutput{}
class DefaultFavouriteListViewModel: FavouriteListViewModel{
    var coordinator: GameBaseCoordinator?
    var useCase: FavouriteGamesUseCase
    private var games: [Game]?
    //MARK: - Output
    var items: Observable<[GamesListItemViewModel]> = Observable([])
    
    init(coordinator: GameBaseCoordinator? = nil, useCase: FavouriteGamesUseCase) {
        self.coordinator = coordinator
        self.useCase = useCase
    }
    
    private func deleteItem(game: Game) {
        useCase.removeFavouriteGame(game: game) { error in
            if error == nil{
                self.fetechData()
            }
        }
    }
    private func fetechData(){
        useCase.fetchFavouriteGamesList {[weak self] games in
            guard let self = self else {return}
            self.games = games
            self.items.value = games.map({GamesListItemViewModel.init(game: $0)})
        }
    }
}

extension DefaultFavouriteListViewModel{
    func viewDidload() {
    }
    func viewWillAppear() {
        fetechData()
    }
    func deleteItem(indexPath: Int) {
        guard let games = games else {return}
        self.deleteItem(game: games[indexPath])
    }
    func didSelect(indexPath: Int) {
        guard let games = games else {return}
        coordinator?.openDetails(game: games[indexPath])
    }
}
