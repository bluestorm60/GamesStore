//
//  FavViewController.swift
//  GamesStore
//
//  Created by Ahmed Shafik on 16/02/2023.
//

import UIKit

class FavViewController: UIViewController {
    private var viewModel: FavouriteListViewModel!
    
    @IBOutlet weak var nodataLbl: UILabel!
    @IBOutlet weak var listTableView: UITableView!{
        didSet{
            listTableView.register(UINib(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavouriteTableViewCell")
        }
    }
    init(viewModel: FavouriteListViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewModel.viewWillAppear()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }
    
    private func bind() {
        viewModel.items.observe(on: self) { [weak self] _ in self?.updateItems() }
    }
    private func updateItems() {
        if viewModel.items.value.count == 0 {
            nodataLbl.isHidden = false
            listTableView.isHidden = true
            title = "Favourites"
        }else{
            listTableView.isHidden = false
            listTableView.reloadData()
            nodataLbl.isHidden = true
            title = "Favourites (\(viewModel.items.value.count))"
        }
    }
    
}
extension FavViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.items.value.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? FavouriteTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(FavouriteTableViewCell.self) with reuseIdentifier: \(FavouriteTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        cell.fill(with: viewModel.items.value[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = view.frame.width
        return width * 0.362666666666667
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            viewModel.deleteItem(indexPath: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(indexPath: indexPath.row)
    }
    
}
