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
    private let pageControl = UIPageControl()
    private let headerView = UIView()
    private let searchVC = SearchViewController()

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
        bindSearchCompletion()
        bindWillDisplayCompletion()
        bindPopoverDidDismiss()
        bindEndSearchCompletion()
    }
    
    private func setBackgroundColor(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func createSearchBar(){
        searchBar.delegate = viewModel
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
        topCollectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
    
        headerView.addSubview(topCollectionView)
        topCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topCollectionView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            topCollectionView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            topCollectionView.topAnchor.constraint(equalTo: headerView.topAnchor),
            topCollectionView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
        ])
        createPageControl()
        return headerView
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
    
    private func createPageControl(){
        self.headerView.addSubview(pageControl)
        pageControl.isUserInteractionEnabled = false
        pageControl.numberOfPages = topCollectionView.numberOfItems(inSection: 0)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: headerView.bottomAnchor),
            pageControl.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            pageControl.widthAnchor.constraint(equalToConstant: 150),
            pageControl.heightAnchor.constraint(equalToConstant: 70)
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

    private func bindSearchCompletion(){
        viewModel.searchCompletion = {
            [weak self] in
            self?.setSearchViewController()
        }
    }
    
    private func setSearchViewController() {
        viewModel.searchDelegate = searchVC.viewModel
        searchVC.modalPresentationStyle = .popover
        self.addChild(searchVC)
        self.view.addSubview(searchVC.view)
        searchVC.didMove(toParent: self)
    }
    
    private func bindWillDisplayCompletion(){
        viewModel.willDisplayCompletion = {
            [weak self] in
            for cell in self!.topCollectionView.visibleCells {
                let indexPath = self?.topCollectionView.indexPath(for: cell)
                self?.pageControl.currentPage = indexPath?.row ?? 0
            }
        }
    }
    
    private func bindPopoverDidDismiss(){
        viewModel.popOverDidDismissCompletion = {
            [weak self] in
            self?.searchBar.endEditing(true)
            self?.searchBar.showsCancelButton = false
        }
    }
    
    private func bindEndSearchCompletion(){
        viewModel.searchEndedCompletion = {
            [weak self] in
            self?.searchVC.view.removeFromSuperview()
        }
    }
    
}
