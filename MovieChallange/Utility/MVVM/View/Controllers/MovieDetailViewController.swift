//
//  MovieDetailViewController.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    let imageView = UIImageView()
    let titleLabel = UILabel()
    let descriptionTextView = UITextView()
    let imdbView = UIView()
    let line = UIView()
    let similarMoviewLabel = UILabel()
    let imdbButton = UIButton()
    let dateLabel = UILabel()
    let starLabel = UILabel()
    var similarMoviesCollectionView: UICollectionView!
    
    var viewModel: MovieDetailViewModel!
    
    init(movieId: Int?) {
        super.init(nibName: nil, bundle: nil)
        viewModel = MovieDetailViewModel(movieId: movieId)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupUI(){
        setBackgroundColor()
        createImageView()
        createTitleLabel()
        createDescriptionTextView()
        createIMDBView()
        createLine()
        createSameMoviesLabel()
        createSameMoviesCollectionView()
        bindMovieDetailData()
        bindSimilarMoviesData()
        bindTapAction()
    }
    
    private func setBackgroundColor(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func createImageView(){
        imageView.backgroundColor = .blue
        self.view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height/3)
        ])
    }
    
    private func createTitleLabel(){
        titleLabel.text = "adfhajskd "
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor)
        ])
    }
    
    private func createDescriptionTextView(){
        descriptionTextView.backgroundColor = .systemBackground
        descriptionTextView.isEditable = false
        self.view.addSubview(descriptionTextView)
        descriptionTextView.text = "ajldfhı d  f sasdohışf ş"
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
        ])
    }
    
    private func createIMDBView(){
        self.view.addSubview(imdbView)
        imdbView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imdbView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imdbView.topAnchor.constraint(equalTo: self.descriptionTextView.bottomAnchor),
            imdbView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        imdbButton.setImage(UIImage(named: "imdbImage"), for: .normal)
        imdbView.addSubview(imdbButton)
        imdbButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imdbButton.widthAnchor.constraint(equalToConstant: 30),
            imdbButton.topAnchor.constraint(equalTo: imdbView.topAnchor),
            imdbButton.bottomAnchor.constraint(equalTo: imdbView.bottomAnchor),
            imdbButton.trailingAnchor.constraint(equalTo: imdbView.trailingAnchor)
        ])
        
        self.imdbView.addSubview(dateLabel)
        dateLabel.text = "afaoshdf "
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.widthAnchor.constraint(equalToConstant: 30),
            dateLabel.trailingAnchor.constraint(equalTo: imdbButton.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: imdbView.topAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: imdbView.bottomAnchor)
        ])
        
        self.imdbView.addSubview(starLabel)
        starLabel.text = "kdjascg ads c "
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starLabel.widthAnchor.constraint(equalToConstant: 15),
            starLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            starLabel.topAnchor.constraint(equalTo: imdbView.topAnchor),
            starLabel.bottomAnchor.constraint(equalTo: imdbView.bottomAnchor)
        ])
        
        let starImageView = UIImageView(image: UIImage(named: "star"))
        self.imdbView.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: 30),
            starImageView.topAnchor.constraint(equalTo: imdbView.topAnchor),
            starImageView.bottomAnchor.constraint(equalTo: imdbView.bottomAnchor),
            starImageView.trailingAnchor.constraint(equalTo: starLabel.leadingAnchor)
        ])
    }
    
    private func createLine(){
        self.view.addSubview(line)
        line.backgroundColor = .rgb_245_245_245
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            line.topAnchor.constraint(equalTo: self.imdbView.bottomAnchor),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func createSameMoviesLabel(){
        similarMoviewLabel.text = Strings.shared.sameMovies
        self.view.addSubview(similarMoviewLabel)
        similarMoviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMoviewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            similarMoviewLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            similarMoviewLabel.topAnchor.constraint(equalTo: self.line.bottomAnchor)
        ])
    }
    
    private func createSameMoviesCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        similarMoviesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        similarMoviesCollectionView.delegate = viewModel
        similarMoviesCollectionView.dataSource = viewModel
        similarMoviesCollectionView.register(SimilarMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "SimilarMoviesCollectionViewCell")
        self.view.addSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            similarMoviesCollectionView.topAnchor.constraint(equalTo: self.similarMoviewLabel.bottomAnchor),
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/5),
            similarMoviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -50)
        ])
    }
    
    
    private func bindMovieDetailData(){
        viewModel.movieDetailCompletion = {
            [weak self] (path, title, description)in
            self?.updateUI(path: path, title: title, description: description)
        }
    }
    
    private func bindSimilarMoviesData(){
        viewModel.similarMoviesCompletion = {
            [weak self] () in
            self?.similarMoviesCollectionView.reloadData()
        }
    }
    
    private func bindTapAction(){
        viewModel.tapCompletion = {
            [weak self] (movie) in
            self?.showDetail(movieId: movie?.id)
        }
    }
    
    private func updateUI(path: String, title: String, description: String){
        updateImageView(path: path)
        updateTitle(title: title)
        updateDescription(description: description)
    }
    
    private func updateImageView(path: String){
        SetImageHandler.setImage(path: path, imageView: imageView)
    }
    
    private func updateTitle(title: String){
        titleLabel.text = title
    }
    
    private func updateDescription(description: String){
        descriptionTextView.text = description
    }
    
    private func showDetail(movieId: Int?){
        let detailVC = MovieDetailViewController(movieId: movieId)
        self.show(detailVC, sender: self)
    }
}
