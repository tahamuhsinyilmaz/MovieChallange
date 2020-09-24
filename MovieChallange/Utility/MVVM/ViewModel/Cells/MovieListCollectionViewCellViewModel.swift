//
//  MovieListCollectionViewCellViewModel.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import Foundation
class MovieListCollectionViewCellViewModel{
    var dataSettedCompletion: ((_ url: String, _ labelText: String)->())?
    var dataSource: Movie?{
        didSet{
            guard let dataSettedCompletion = dataSettedCompletion else {return}
            let url = dataSource?.poster_path ?? ""
            let labelText = dataSource?.title ?? ""
            dataSettedCompletion(url, labelText)
        }
    }
}
