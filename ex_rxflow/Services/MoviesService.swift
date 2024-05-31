//
//  MoviesService.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation

protocol HasMoviesService {
    var moviesService: MoviesService { get }
}

class MoviesService {
    func wishlistMovies() -> [Movie] {
        return MoviesRepository.movies.filter { !$0.watched }
    }
    
    func watchedMovies() -> [Movie] {
        return MoviesRepository.movies.filter { $0.watched }
    }
    
    func movie(forId id: Int) -> Movie {
        return MoviesRepository.movies.filter { $0.id == id }.first!
    }
    
    func cast(forId id: Int) -> Cast {
        return CastsRepository.casts.filter { $0.id == id }.first!
    }
    
    func casts(for movie: Movie) -> [Cast] {
        let items = CastsRepository.casts
        if (movie.id % 2 == 0){
            return [items[0],items[2],items[4],items[6],items[8],]
        }
        return [items[1],items[3],items[5],items[7],items[9]]
    }
}
