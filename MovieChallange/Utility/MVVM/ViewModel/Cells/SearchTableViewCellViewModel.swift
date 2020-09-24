//
//  SearchTableViewCellViewModel.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import Foundation

class SearchTableViewCellViewModel{
    var completion: ((_ title: String, _ date: String)->())?
    var movie: Movie!{
        didSet{
            guard let completion = self.completion else {return}
            let title = movie.title ?? ""
            let date = movie.release_date ?? ""
            completion(title, date)
        }
    }
}
