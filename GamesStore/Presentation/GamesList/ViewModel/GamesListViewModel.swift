//
//  GamesListViewModel.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import Foundation

enum GamesListViewModelLoading {
    case fullScreen
    case nextPage
}
protocol GamesListViewModelInput {
    func viewDidLoad()
    func didLoadNextPage()
    func didSearch(query: String)
    func didCancelSearch()
    func didSelectItem(at index: Int)
}

protocol GamesListViewModelOutput {
    var items: Observable<[GamesListItemViewModel]> { get }
    var loading: Observable<GamesListViewModelLoading?> { get }
    var query: Observable<String> { get }
    var error: Observable<String> { get }
    var isEmpty: Bool { get }
    var screenTitle: String { get }
    var emptyDataTitle: String { get }
    var errorTitle: String { get }
    var searchBarPlaceholder: String { get }
}
protocol GamesListViewModel: GamesListViewModelInput, GamesListViewModelOutput {}

final class DefaultGamesListViewModel: GamesListViewModel{
    private let searchGamesUseCase: SearchGamesUseCase
    
    var currentPage: Int = 0
    var totalPageCount: Int = 1
    var hasMorePages: Bool { items.value.count < totalPageCount }
    var nextPage: Int { hasMorePages ? currentPage + 1 : currentPage }
    private let pageSize = 10
    private var pages: [GamesPage] = []
    private var gamesLoadTask: Cancellable? { willSet { gamesLoadTask?.cancel() } }
    private var coordinator: GamesListBaseCoordinator?

    // MARK: - OUTPUT
    
    let items: Observable<[GamesListItemViewModel]> = Observable([])
    let loading: Observable<GamesListViewModelLoading?> = Observable(.none)
    let query: Observable<String> = Observable("")
    let error: Observable<String> = Observable("")
    var isEmpty: Bool { return items.value.isEmpty }
    let screenTitle = NSLocalizedString("Games", comment: "")
    let emptyDataTitle = NSLocalizedString("Search results", comment: "")
    let errorTitle = NSLocalizedString("Error", comment: "")
    let searchBarPlaceholder = NSLocalizedString("Search Games", comment: "")
    
    // MARK: - Init
    
    init(searchGamesUseCase: SearchGamesUseCase, coordinator: GamesListBaseCoordinator) {
        self.searchGamesUseCase = searchGamesUseCase
        self.coordinator = coordinator
    }
    
    // MARK: - Private
    
    private func appendPage(_ gamesPage: GamesPage) {
        currentPage = gamesPage.page
        totalPageCount = gamesPage.count
        //        totalPageCount = gamesPage.totalPages
        
        pages = pages
            .filter { $0.page != gamesPage.page }
        + [gamesPage]
        self.loading.value = .none

        items.value = pages.games.map(GamesListItemViewModel.init)
    }
    
    private func resetPages() {
        currentPage = 0
        totalPageCount = 1
        pages.removeAll()
        items.value.removeAll()
    }
    
    private func load(gameQuery: GameQuery, loading: GamesListViewModelLoading) {
        self.loading.value = loading
        query.value = gameQuery.query
        
        gamesLoadTask = searchGamesUseCase.execute(
            requestValue: .init(query: gameQuery, page: nextPage, pageSize: pageSize),
            cached: appendPage,
            completion: { result in
                switch result {
                case .success(let page):
                    self.appendPage(page)
                case .failure(let error):
                    self.handle(error: error)
                }
            })
    }
    
    private func handle(error: Error) {
        self.error.value = error.isInternetConnectionError ?
        NSLocalizedString("No internet connection", comment: "") :
        NSLocalizedString("Failed loading movies", comment: "")
    }
    
    private func update(gameQuery: GameQuery) {
        resetPages()
        load(gameQuery: gameQuery, loading: .fullScreen)
    }
    
    
}
// MARK: - INPUT. View event methods

extension DefaultGamesListViewModel {
    
    func viewDidLoad() { }
    
    func didLoadNextPage() {
        guard hasMorePages, loading.value == .none else { return }
        load(gameQuery: .init(query: query.value),
             loading: .nextPage)
    }
    
    func didSearch(query: String) {
        guard !query.isEmpty else { return }
        update(gameQuery: GameQuery(query: query))
    }
    
    func didCancelSearch() {
        gamesLoadTask?.cancel()
    }
    
    
    func didSelectItem(at index: Int) {
//        actions?.showGameDetails(pages.games[index])
    }
}

// MARK: - Private

private extension Array where Element == GamesPage {
    var games: [Game] { flatMap { $0.games } }
}
