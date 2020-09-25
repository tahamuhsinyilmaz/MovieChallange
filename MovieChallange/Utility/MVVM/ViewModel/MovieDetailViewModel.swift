//
//  MovieDetailViewModel.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class MovieDetailViewModel: NSObject{
    var tapCompletion: ((Movie?)->())?
    var movieDetailCompletion: ((_ path: String, _ title: String, _ description: String, _ date: String, _ rate: String)->())?
    var similarMoviesCompletion: (()->())?
    var imdbIdCompletion: ((_ imdbId: String)->())!
    var movieId: Int?
    var similarMovies: [Movie]?
    var similarMoviesResponse: MoviesResponse!{
        didSet{
            guard let similarMoviesCompletion = self.similarMoviesCompletion else {return}
            similarMoviesCompletion()
        }
    }
    var movieDetail: MovieDetailServiceResponse!{
        didSet{
            guard let movieDetailCompletion = self.movieDetailCompletion else {return}
            let imagePath = movieDetail.poster_path ?? ""
            let title = movieDetail.title ?? ""
            let description = movieDetail.overview ?? ""
            let date = movieDetail.release_date ?? ""
            let rate = String(movieDetail.vote_average ?? 0) 
            movieDetailCompletion(imagePath, title, description, date, rate)
        }
    }
    
    init(movieId: Int?){
        super.init()
        self.movieId = movieId
        self.fetchMovieDetail()
        self.fetchSimilarMovies()
    }
    
    private func fetchMovieDetail(){
        APIService.shared.fetchMovieDetail(movieId: movieId) { (movieDetail, error) in
            if error == nil{
                self.movieDetail = movieDetail
                self.imdbIdCompletion(movieDetail?.imdb_id ?? "")
            }else{
                
            }
        }
    }
    
    private func fetchSimilarMovies(){
        APIService.shared.fetchSimilarMovies(movieId: movieId) { (moviesResponse, error) in
            if error == nil{
                self.similarMoviesResponse = moviesResponse
                self.similarMovies = moviesResponse?.results
            }else{
                
            }
        }
    }
}

extension MovieDetailViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarMoviesCollectionViewCell", for: indexPath) as! SimilarMoviesCollectionViewCell
        cell.viewModel.movie = self.similarMovies?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: collectionView.frame.height-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tapCompletion = self.tapCompletion else {return}
        tapCompletion(similarMovies?[indexPath.row])
    }
    
}
