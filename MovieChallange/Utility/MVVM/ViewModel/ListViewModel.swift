//
//  ListViewModel.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import UIKit

class ListViewModel: NSObject{
    var nowPlayingCompletion: (()->())!
    var upcomingPlayingCompletion: (()->())!
    var createColletionCompletion: (()->UIView)!
    var tapCellCompletion: ((_ movieId: Int?)->())!
    private var nowPlayingDataSource: [Movie]?{
        didSet{
            nowPlayingCompletion()
        }
    }
    private var upcomingDataSource: [Movie]?{
        didSet{
            upcomingPlayingCompletion()
        }
    }
    
    override init(){
        super.init()
        fetchNowPlaying()
        fetchUpcoming()
    }
    
    private func fetchNowPlaying(){
        APIService.shared.fetchNowPlayingData {[weak self] (moviesResponse, error) in
            if error == nil {
                guard  let movies = moviesResponse?.results else {return}
                self?.nowPlayingDataSource = movies
            }else{
                
            }
        }
    }
    
    private func fetchUpcoming(){
        APIService.shared.fetchUpcomingData {[weak self] (moviesResponse, error) in
            if error == nil {
                guard  let movies = moviesResponse?.results else {return}
                self?.upcomingDataSource = movies
            }else{
                
            }
        }
    }
    
}

extension ListViewModel: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return createColletionCompletion()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.frame.height/3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingDataSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell") as! MovieListTableViewCell
        cell.viewModel.dataSource = upcomingDataSource?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tapCellCompletion(upcomingDataSource?[indexPath.row].id)
    }
}

extension ListViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingDataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        cell.viewModel.dataSource = nowPlayingDataSource?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tapCellCompletion(nowPlayingDataSource?[indexPath.row].id)
    }
    
}
