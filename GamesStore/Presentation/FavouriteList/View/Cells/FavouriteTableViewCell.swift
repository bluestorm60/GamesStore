//
//  FavouriteTableViewCell.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {
    private var viewModel: GamesListItemViewModel!
    static let reuseIdentifier = String(describing: FavouriteTableViewCell.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gamePosterImgeView: UIImageView!
    
    @IBOutlet weak var gameTitleLbl: UILabel!
    
    @IBOutlet weak var genersLbl: UILabel!
    
    @IBOutlet weak var metaCriticsValueLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fill(with viewModel: GamesListItemViewModel) {
        self.viewModel = viewModel
        gameTitleLbl.text = viewModel.title
        genersLbl.text = viewModel.genres
        metaCriticsValueLbl.text = "\(viewModel.metaCritic ?? 0)"
        guard let imgeUrl = viewModel.image, let requestURL = URL(string: imgeUrl) else {return}
        gamePosterImgeView.image = nil
        gamePosterImgeView.load(url: requestURL)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
