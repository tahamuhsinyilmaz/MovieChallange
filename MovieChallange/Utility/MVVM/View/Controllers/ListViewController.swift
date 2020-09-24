//
//  ListViewController.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class ListViewController: UIViewController {
    
    private let viewModel = ListViewModel()
    private let searchBar = UISearchBar()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private var topCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func initViewController(){
        setBackgroundColor()
        createSearchBar()
        createTableView()
        bindTableView()
        bindCollectionView()
        bindTapActions()
    }
    private func setBackgroundColor(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func createSearchBar(){
        searchBar.placeholder = Strings.shared.searchPlaceholder
        self.navigationItem.titleView = searchBar
    }
    
    private func createCollectionView()-> UIView{
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.minimumInteritemSpacing = 0
        collectionViewLayout.minimumLineSpacing = 0
        topCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: collectionViewLayout)
        topCollectionView.delegate = viewModel
        topCollectionView.dataSource = viewModel
        topCollectionView.backgroundColor = .white
        topCollectionView.isPagingEnabled = true
        topCollectionView.register(MovieListCollectionViewCell.self,
                                   forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        return topCollectionView
    }
    
    private func createTableView(){
        view.addSubview(tableView)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(MovieListTableViewCell.self, forCellReuseIdentifier: "MovieListTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func bindTableView(){
        viewModel.upcomingPlayingCompletion = {
            [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func bindCollectionView(){
        viewModel.createColletionCompletion = {
            [weak self] in
            return (self?.createCollectionView())!
        }
        
        viewModel.nowPlayingCompletion = {
            [weak self] in
            self?.topCollectionView.reloadData()
        }
    }
    
    private func bindTapActions(){
        viewModel.tapCellCompletion = {[weak self]
            (movieId) in
            guard let id = movieId else {return}
            let detailVC = MovieDetailViewController(movieId: id)
            self?.show(detailVC, sender: self)
        }
    }

}
