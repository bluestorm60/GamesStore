//
//  GameDetailsViewModel.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import Foundation
enum GameDetailsViewModelLoading {
    case loading
}

protocol GameDetailsViewModelInput {
    func viewDidLoad()
    func viewWillAppear()
    func favouriteHandling()
}

protocol GameDetailsViewModelOutput {
    var gameData: Observable<GameDetails?> { get }
    var loading: Observable<GameDetailsViewModelLoading?> { get }
    var error: Observable<String> { get }
    var screenTitle: String { get }
    var errorTitle: String { get }
    var isFav: Observable<Bool> {get}
    var favTitle: String { get }

}
protocol GameDetailsViewModel: GameDetailsViewModelInput, GameDetailsViewModelOutput {}

final class DefaultGameDetailsViewModel: GameDetailsViewModel {
    
    private let gameDetailsUseCase: GameDetailsUseCase
    private var coordinator: GameDetailsBaseCoordinator?

    private let game: Game
    private var gamesLoadTask: Cancellable? { willSet { gamesLoadTask?.cancel() } }

    // MARK: - OUTPUT
    
    let gameData: Observable<GameDetails?> = Observable(nil)
    let loading: Observable<GameDetailsViewModelLoading?> = Observable(.none)
    let error: Observable<String> = Observable("")
    var screenTitle = ""
    let errorTitle = "Error"
    
    var favTitle: String = "Favourite"
    var isFav: Observable<Bool> = Observable(false)

    init(gameDetailsUseCase: GameDetailsUseCase, game: Game,coordinator: GameDetailsBaseCoordinator? = nil) {
        self.gameDetailsUseCase = gameDetailsUseCase
        self.game = game
        self.screenTitle = game.title ?? ""
        self.coordinator = coordinator
    }
    
    private func getGameDetails(){
        self.loading.value = .loading
        gamesLoadTask = gameDetailsUseCase.getGameDetails(gameId: Int(self.game.id)!, completion: {[weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let gameDetails):
                self.gameData.value = gameDetails
            case .failure(let error):
                self.handle(error: error)
            }
            self.loading.value = .none
        })
    }
    
    private func checkIsFavourite(){
        gameDetailsUseCase.isFavourited(game: self.game) {[weak self] isFav in
            guard let self = self else {return}
            self.favTitle = isFav ? "Favourited" : "Favourite"
            self.isFav.value = isFav
        }
    }
    
    private func addToFavouriteRequest(){
        gameDetailsUseCase.saveFavouriteGame(game: self.game) {[weak self] error in
            guard let self = self else {return}
            if error == nil{
                self.favTitle = "Favourited"
                self.isFav.value = true
            }
        }
    }
    private func removeFavouriteRequest(){
        gameDetailsUseCase.removeFavouriteGame(game: self.game) {[weak self] error in
            guard let self = self else {return}
            if error == nil{
                self.favTitle = "Favourite"
                self.isFav.value = false
            }
        }
    }
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ? "No internet connection" : "Failed loading game details"
    }


}

extension DefaultGameDetailsViewModel{
    func favouriteHandling(){
        if isFav.value{
            removeFavouriteRequest()
        }else{
            addToFavouriteRequest()
        }
    }
    

    func viewDidLoad() {
        checkIsFavourite()
    }
    
    func viewWillAppear() {
        self.getGameDetails()
    }
}
