//
//  GameDetailsViewController.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 18/02/2023.
//

import UIKit

class GameDetailsViewController: UIViewController, Alertable {
    //MARK: - Properties
    private var viewModel: GameDetailsViewModel!

    
    //MARK: - Outlets
    @IBOutlet weak var gamePosterImgeView: UIImageView!
    @IBOutlet weak var gameTitleLbl: UILabel!
    @IBOutlet weak var gameDescriptionLbl: UILabel!
    

    //MARK: - Initialization
    init(viewModel: GameDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = ""
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false

        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    private func bind() {
        viewModel.gameData.observe(on: self) { [weak self] gameData in
            guard let self = self, let gameData = gameData else {return}
            self.updateGameData(gameData)
        }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    private func updateGameData(_ gameData: GameDetails) {
        gameDescriptionLbl.attributedText = gameData.gameDescription?.convertHtmlToNSAttributedString
        gameTitleLbl.text = gameData.title
        title = gameData.title
        if let imgeUrl = gameData.gameImge, let requestURL = URL(string: imgeUrl) {
            gamePosterImgeView.load(url: requestURL)
        }
    }
    private func updateLoading(_ loading: GameDetailsViewModelLoading?) {
        switch loading {
        case .loading: LoadingView.show()
        default:
            LoadingView.hide()
        }
    }
    
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }

    private func openUrl(urlString: String?){
        if let urlString = urlString, let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
    @IBAction func visitRedditAction(_ sender: Any) {
            self.openUrl(urlString: self.viewModel.gameData.value?.redditUrl)
    }
    @IBAction func visitWebsiteAction(_ sender: Any) {
        self.openUrl(urlString: self.viewModel.gameData.value?.gameWebSite)
    }
}

extension String {
    public var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,options: [.documentType: NSAttributedString.DocumentType.html,.characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error.localizedDescription)
            return nil
        }
    }

    public func convertHtmlToAttributedStringWithCSS(font: UIFont? , csscolor: String , lineheight: Int, csstextalign: String) -> NSAttributedString? {
        guard let font = font else {
            return convertHtmlToNSAttributedString
        }
        let modifiedString = "<style>body{font-family: '\(font.fontName)'; font-size:\(font.pointSize)px; color: \(csscolor); line-height: \(lineheight)px; text-align: \(csstextalign); }</style>\(self)";
        guard let data = modifiedString.data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch {
            print(error)
            return nil
        }
    }
}
