//
//  MovieDetailViewController.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionTextView = UITextView()
    private let imdbView = UIView()
    private let line = UIView()
    private let similarMoviewLabel = UILabel()
    private let imdbButton = UIButton()
    private let dateLabel = UILabel()
    private let starLabel = UILabel()
    private var imdbId = ""
    private var similarMoviesCollectionView: UICollectionView!
    private var viewModel: MovieDetailViewModel!
    
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
        bindImdbCompletion()
    }
    
    private func setBackgroundColor(){
        self.view.backgroundColor = .systemBackground
    }
    
    private func createImageView(){
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
        self.view.addSubview(titleLabel)
        titleLabel.font = .boldSystemFont(ofSize: 21)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 10)
        ])
    }
    
    private func createDescriptionTextView(){
        descriptionTextView.backgroundColor = .systemBackground
        descriptionTextView.isEditable = false
        descriptionTextView.font = .systemFont(ofSize: 18)
        self.view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionTextView.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor),
            descriptionTextView.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func createIMDBView(){
        self.view.addSubview(imdbView)
        imdbView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imdbView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            imdbView.topAnchor.constraint(equalTo: self.descriptionTextView.bottomAnchor),
            imdbView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            imdbView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        imdbButton.setImage(UIImage(named: "imdbImage"), for: .normal)
        imdbButton.addTarget(self, action: #selector(imdbButtonAction), for: .touchUpInside)
        imdbView.addSubview(imdbButton)
        imdbButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imdbButton.widthAnchor.constraint(equalToConstant: 80),
            imdbButton.topAnchor.constraint(equalTo: imdbView.topAnchor),
            imdbButton.bottomAnchor.constraint(equalTo: imdbView.bottomAnchor),
            imdbButton.trailingAnchor.constraint(equalTo: imdbView.trailingAnchor, constant: -10)
        ])
        
        self.imdbView.addSubview(dateLabel)
        dateLabel.font = .systemFont(ofSize: 10)
        dateLabel.textColor = .lightGray
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.trailingAnchor.constraint(equalTo: imdbButton.leadingAnchor, constant: -10),
            dateLabel.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor)
        ])
        
        self.imdbView.addSubview(starLabel)
        starLabel.font = .systemFont(ofSize: 10)
        starLabel.textColor = .lightGray
        starLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starLabel.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -10),
            starLabel.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor)
        ])
        
        let starImageView = UIImageView(image: UIImage(named: "star"))
        self.imdbView.addSubview(starImageView)
        starImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            starImageView.widthAnchor.constraint(equalToConstant: 25),
            starImageView.heightAnchor.constraint(equalToConstant: 25),
            starImageView.centerYAnchor.constraint(equalTo: imdbView.centerYAnchor),
            starImageView.trailingAnchor.constraint(equalTo: starLabel.leadingAnchor, constant: -5)
        ])
    }
    
    private func createLine(){
        self.view.addSubview(line)
        line.backgroundColor = .rgb_245_245_245
        line.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            line.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            line.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            line.topAnchor.constraint(equalTo: self.imdbView.bottomAnchor, constant: 20),
            line.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func createSameMoviesLabel(){
        similarMoviewLabel.text = Strings.shared.sameMovies
        similarMoviewLabel.textColor = .gray
        similarMoviewLabel.font = .systemFont(ofSize: 20)
        self.view.addSubview(similarMoviewLabel)
        similarMoviewLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMoviewLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            similarMoviewLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            similarMoviewLabel.topAnchor.constraint(equalTo: self.line.bottomAnchor, constant: 20)
        ])
    }
    
    private func createSameMoviesCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        similarMoviesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        similarMoviesCollectionView.delegate = viewModel
        similarMoviesCollectionView.dataSource = viewModel
        similarMoviesCollectionView.backgroundColor = .systemBackground
        similarMoviesCollectionView.register(SimilarMoviesCollectionViewCell.self, forCellWithReuseIdentifier: "SimilarMoviesCollectionViewCell")
        self.view.addSubview(similarMoviesCollectionView)
        similarMoviesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            similarMoviesCollectionView.leadingAnchor.constraint(equalTo: self.similarMoviewLabel.leadingAnchor),
            similarMoviesCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            similarMoviesCollectionView.topAnchor.constraint(equalTo: self.similarMoviewLabel.bottomAnchor, constant: 10),
            similarMoviesCollectionView.heightAnchor.constraint(equalToConstant: self.view.frame.height/5),
            similarMoviesCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    
    private func bindMovieDetailData(){
        viewModel.movieDetailCompletion = {
            [weak self] (path, title, description, date, rate)in
            self?.updateUI(path: path, title: title, description: description, date: date, rate: rate)
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
    
    private func bindImdbCompletion(){
        viewModel.imdbIdCompletion = {
            [weak self] (imdbId) in
            self?.imdbId = imdbId
        }
    }
    
    private func updateUI(path: String, title: String, description: String, date: String, rate: String){
        updateImageView(path: path)
        updateTitle(title: title)
        updateDescription(description: description)
        updateDateLabel(date: date)
        updateStarLabel(rate: rate)
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
    
    private func updateStarLabel(rate: String){
        starLabel.text = rate
    }
    
    private func updateDateLabel(date: String){
        let dateComponents = date.split(separator: "-")
        let year = dateComponents.first ?? ""
        var month: String = ""
        if !dateComponents.isEmpty { month = String(dateComponents[1])}
        let day = dateComponents.last ?? ""
        dateLabel.text = "\(day).\(month).\(year)"
    }
    
    @objc private func imdbButtonAction(){
        let urlString = Constants.shared.imdbEndPoint + imdbId
        guard let url = URL(string: urlString) else {return}
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
