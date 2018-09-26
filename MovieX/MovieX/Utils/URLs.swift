//
//  URLs.swift
//  MovieX
//
//  Created by Da on 9/7/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

struct URLs {
    private static var apiBaseUrl = "https://api.themoviedb.org/3"
    
    public static let apiMovies = apiBaseUrl + "/genre/"
    
    public static let apiGenresUrl = apiBaseUrl + "/genre/movie/list"
    
    public static let apiSearchUser = apiBaseUrl + "/search/company"
    
    public static let apiMoviesByGenres = apiBaseUrl + "/genre/"
//    "/list/"
    
    public static let apiMovieTopRated = apiBaseUrl + "/movie/top_rated"
    
    public static let apiMoviePopular = apiBaseUrl + "/movie/popular"
    
    public static let apiMovieUpcoming = apiBaseUrl + "/movie/upcoming"
    
    public static let apiMovieNowPlaying = apiBaseUrl + "/movie/now_playing"
    
    public static let apiGetId = apiBaseUrl + "/movie/"
    
    public static let APIMovieDetailURL = apiBaseUrl + "/movie/"
    
    public static let apiCredit = apiBaseUrl + "/movie/"
    
    public static let apiMoviesByCredit = apiBaseUrl + "/person/"
    
    public static let apiPosterImage = "https://image.tmdb.org/t/p/w300_and_h450_bestv2"
    
    public static let apiBackdropImage = "https://image.tmdb.org/t/p/original"
    
    public static let apiMovieSearch = apiBaseUrl + "/search/movie"
}
