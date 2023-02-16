//
//  GamesListViewController.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

class GamesListViewController: UIViewController {
    var coordinator: GamesListBaseCoordinator?

    init(coordinator: GamesListBaseCoordinator) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
        title = "Games"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
