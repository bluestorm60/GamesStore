//
//  ViewController.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 13/02/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let container = AppDIContainer()
        let repo = DefaultGamesRepository(dataTransferService: container.apiDataTransferService, cache: CoreDataGamesResponseStorage())
        let useCase = DefaultSearchGamesUseCase(gamesRepository: repo)
        useCase.execute(requestValue: SearchGamesUseCaseRequestValue(query: GameQuery(query: "gtav"), page: 1, pageSize: 10)) { result in
            print(result)
        } completion: { result in
            switch result{
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let page):
                print(page)
            }
        }

    }


}

