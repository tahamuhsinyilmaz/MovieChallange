//
//  SimilarMoviewCollectionViewCellViewModel.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import Foundation
class SimilarMoviesCollectionViewCellViewModel{
    var completion: ((_ path: String, _ title: String, _ date: String)->())?
    var movie: Movie!{
        didSet{
            guard let completion = self.completion else {return}
            let path = movie.poster_path ?? ""
            let title = movie.title ?? ""
            let date = movie.release_date ?? ""
            completion(path, title, date)
        }
    }
}
