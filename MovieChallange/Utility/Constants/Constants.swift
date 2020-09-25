//
//  Constants.swift
//  MovieChallange
//
//  Created by onedio on 23.09.2020.
//

import Foundation
class Constants{
    private init(){}
    static var shared = Constants()
    
    let endPoint: String = "https://api.themoviedb.org/3"
    let apiKey: String = "ebe002c21f8d6f99dfd0be2652a4bf44"
    let imdbEndPoint = "https://www.imdb.com/title/"
    let nowPlaying: String = "/movie/now_playing"
    let upcoming: String = "/movie/upcoming"
    let baseImageUrl : String = "https://image.tmdb.org/t/p/w500"
    let movieDetail: String = "/movie/"
    let similarMovies: String = "/similar"
    let search: String = "/search/movie"
}
