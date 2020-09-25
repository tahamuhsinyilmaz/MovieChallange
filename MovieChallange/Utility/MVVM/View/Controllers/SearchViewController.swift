//
//  SearchViewController.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class SearchViewController: UIViewController {

    let viewModel = SearchViewModel()
    private let tableView = UITableView()
    
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
        setView()
        setTableView()
        bindTableView()
        bindTapCompletion()
    }
    
    private func setView(){
        self.view.backgroundColor = .clear
    }
    
    private func setTableView(){
        self.view.addSubview(tableView)
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.dataSource = viewModel
        tableView.delegate = viewModel
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 1.5*self.view.frame.height/3)
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
            self?.show(detailVC, sender: self)
        }
    }

}
