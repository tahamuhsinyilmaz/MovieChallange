//
//  SearchViewModel.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class SearchViewModel: NSObject{
    var completion: (()->())?
    var tapCompletion: ((_ movieId: Int?)->())?
    var movies: [Movie]?{
        didSet{
            guard let completion = self.completion else {return}
            completion()
        }
    }
    
    override init() {
        super.init()
    }
    
    private func fetchSearchResult(text: String){
        APIService.shared.fetchSearchResult(text: text) { (moviesResponse, error) in
            if error == nil {
                guard let movies = moviesResponse?.results else {return}
                self.movies = movies
            }else{
                
            }
        }
    }
}

extension SearchViewModel: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as! SearchTableViewCell
        cell.viewModel.movie = movies?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tapCompletion = self.tapCompletion else {return}
        tapCompletion(movies?[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension SearchViewModel: SearchDelegate{
    func searchText(text: String) {
        self.fetchSearchResult(text: text)
    }
}
