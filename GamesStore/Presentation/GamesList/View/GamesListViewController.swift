//
//  GamesListViewController.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

class GamesListViewController: UIViewController, Alertable {
    //MARK: - Properties
    private var viewModel: GamesListViewModel!

    //MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private var emptyDataLabel: UILabel!

    @IBOutlet weak var searchCollectionView: UICollectionView! {
        didSet{
            searchCollectionView.register(UINib(nibName: "GamesListItemCell", bundle: nil), forCellWithReuseIdentifier: "GamesListItemCell")
//            searchCollectionView.collectionViewLayout = AutoInvalidatingLayout()
        }
    }

    
    //MARK: - Initialization
    init(viewModel: GamesListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        title = viewModel.screenTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupViews()
        setupSearchController()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        searchBar.endEditing(true)
    }

    private func bind() {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
        viewModel.loading.observe(on: self) { [weak self] in self?.updateLoading($0) }
        viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
    }
    
    // MARK: - Private

    private func setupViews() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        title = viewModel.screenTitle
        emptyDataLabel.text = viewModel.emptyDataTitle
    }
    
    private func updateItems() {
        searchCollectionView?.reloadData()
    }
    private func updateLoading(_ loading: GamesListViewModelLoading?) {
        emptyDataLabel.isHidden = true
        searchCollectionView.isHidden = true
        LoadingView.hide()

        switch loading {
        case .fullScreen: LoadingView.show()
        case .nextPage: searchCollectionView.isHidden = false
        case .none:
            searchCollectionView.isHidden = viewModel.isEmpty
            emptyDataLabel.isHidden = !viewModel.isEmpty
        }
    }
    private func showError(_ error: String) {
        guard !error.isEmpty else { return }
        showAlert(title: viewModel.errorTitle, message: error)
    }



}
// MARK: - Search Controller

extension GamesListViewController {
    private func setupSearchController() {
        searchBar.delegate = self
        searchBar.delegate = self
        searchBar.placeholder = viewModel.searchBarPlaceholder
    }
}

extension GamesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 3 {
            viewModel.didCancelSearch()
            viewModel.didSearch(query: searchText)
        }else{
            viewModel.clearSearch()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearSearch()
        guard let searchText = searchBar.text, !searchText.isEmpty else {  return }
        viewModel.didCancelSearch()
        viewModel.didSearch(query: searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didCancelSearch()
    }
}


extension GamesListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesListItemCell.reuseIdentifier,
                                                       for: indexPath) as? GamesListItemCell else {
            assertionFailure("Cannot dequeue reusable cell \(GamesListItemCell.self) with reuseIdentifier: \(GamesListItemCell.reuseIdentifier)")
            return UICollectionViewCell()
        }

        cell.fill(with: viewModel.items.value[indexPath.row])

        if indexPath.row == viewModel.items.value.count - 1 {
            viewModel.didLoadNextPage()
        }
        cell.itemClicked = { [weak self] in
            guard let self = self else {return}
            self.viewModel.didSelectItem(at: indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width * 0.362666666666667)
    }
    
}


