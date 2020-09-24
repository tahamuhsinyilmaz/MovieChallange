//
//  MovieListTableViewCellViewModel.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import Foundation
class MovieListTableViewCellViewModel{
    
    var dataSettedCompletion: ((_ url: String, _ title: String, _ description: String)->())?
    var dataSource: Movie?{
        didSet{
            guard let dataSettedCompletion = dataSettedCompletion else {return}
            let url = self.dataSource?.backdrop_path ?? ""
            let title = self.dataSource?.title ?? ""
            let description = self.dataSource?.overview ?? ""
            dataSettedCompletion(url, title, description)
        }
    }
    
}
