//
//  GamesListItemCell.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

class GamesListItemCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: GamesListItemCell.self)

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var gamePosterImgeView: UIImageView!
    
    @IBOutlet weak var gameTitleLbl: UILabel!
    
    @IBOutlet weak var genersLbl: UILabel!
    
    @IBOutlet weak var metaCriticsValueLbl: UILabel!
    
    private var viewModel: GamesListItemViewModel!
    private var posterImagesRepository: PosterImagesRepository?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fill(with viewModel: GamesListItemViewModel, posterImagesRepository: PosterImagesRepository?) {
        self.viewModel = viewModel
        gameTitleLbl.text = viewModel.title
        genersLbl.text = viewModel.genres
        metaCriticsValueLbl.text = "\(viewModel.metaCritic ?? 0)"
        handleSelectionColor()
        guard let imgeUrl = viewModel.image, let requestURL = URL(string: imgeUrl) else {return}
        gamePosterImgeView.image = nil
        gamePosterImgeView.load(url: requestURL)
    }
    private func handleSelectionColor(){
        containerView.backgroundColor =  viewModel.selected ? UIColor.appColor(.selectedColor) : UIColor.white
    }
    @IBAction func selectedCell(_ sender: Any) {
        viewModel.selected = true
        handleSelectionColor()
    }
    
}
var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(url: URL) {
        if let image = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage{
            self.image = image
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {[weak self] in
                        imageCache.setObject(image, forKey: url.absoluteString as NSString)
                        self?.image = image
                    }
                }
            }
        }
    }
}
