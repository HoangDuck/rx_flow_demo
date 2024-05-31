//
//  WishlistViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import RxSwift
import RxCocoa
import RxFlow

class WishlistViewModel: ServicesViewModel, Stepper {
    typealias Services = HasMoviesService
    
    let steps = PublishRelay<Step>()
    private(set) var movies: [MovieViewModel]
    
    var services: Services! {
        didSet {
        // we can do some data refactoring in order to display things exactly the way we want (this is the aim of a ViewModel)
            self.movies = self.services.moviesService.wishlistMovies().map({ (movie) -> MovieViewModel in
                return MovieViewModel(id: movie.id, title: movie.title, image: movie.image)
            })
        }
    }

    init() {
        self.movies = [MovieViewModel]()
    }

    public func pick (movieId: Int) {
        self.steps.accept(DemoStep.movieIsPicked(withId: movieId))
    }
}
