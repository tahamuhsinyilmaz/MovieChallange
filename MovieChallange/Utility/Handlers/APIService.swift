//
//  APIService.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import Foundation
class APIService{
    private init(){}
    static var shared = APIService()
    
    func fetchNowPlayingData(completion: @escaping (_ data : MoviesResponse?, _ error: Error?)-> Void){
        let url = Constants.shared.endPoint + Constants.shared.nowPlaying
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func fetchUpcomingData(completion: @escaping (_ data : MoviesResponse?, _ error: Error?)-> Void){
        let url = Constants.shared.endPoint + Constants.shared.upcoming
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func fetchMovieDetail(movieId: Int?, completion: @escaping (_ data : MovieDetailServiceResponse?, _ error: Error?)-> Void){
        guard  let id = movieId else {return}
        let url = Constants.shared.endPoint + Constants.shared.movieDetail + String(id)
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(MovieDetailServiceResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    
    func fetchSimilarMovies(movieId: Int?, completion: @escaping (_ data : MoviesResponse?, _ error: Error?)-> Void){
        guard  let id = movieId else {return}
        let url = Constants.shared.endPoint + Constants.shared.movieDetail + String(id) + Constants.shared.similarMovies
        NetworkHandler.sendRequest(url: url) { (data, error) in
            guard let data = data?.data else {
                completion(nil, nil)
                return
            }
            do {
                let object = try JSONDecoder().decode(MoviesResponse.self, from: data)
                completion(object,nil)
                
            }catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
