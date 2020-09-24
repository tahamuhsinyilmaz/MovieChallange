//
//  SearchViewController.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()
    let tableView = UITableView()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupUI(){
        setTableView()
        bindTableView()
        bindTapCompletion()
    }
    
    private func setTableView(){
        self.view.addSubview(tableView)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func bindTableView(){
        viewModel.completion = {
            [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func bindTapCompletion(){
        viewModel.tapCompletion = {
            [weak self] (movieId) in
            let detailVC = MovieDetailViewController(movieId: movieId)
            self?.present(detailVC, animated: true, completion: nil)
        }
    }

}
