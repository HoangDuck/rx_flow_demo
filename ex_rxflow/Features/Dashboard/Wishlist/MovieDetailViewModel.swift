//
//  MovieDetailViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxFlow
import RxCocoa

class MovieDetailViewModel: ServicesViewModel, Stepper{
    typealias Services = HasMoviesService
    let steps = PublishRelay<Step>()
    
    var services: Services! {
        didSet {
            let movie = self.services.moviesService.movie(forId: movieId)
            self.casts = self.services.moviesService.casts(for: movie).map({ (cast) -> CastViewModel in
                return CastViewModel(id: cast.id, name: cast.name, image: cast.image)
            })
        
            self.title = movie.title
            self.description = movie.description
            self.year = "\(movie.year)"
            self.director = movie.director
            self.writer = movie.writer
            self.image = movie.image

            let currencyFormatter = NumberFormatter()
            currencyFormatter.usesGroupingSeparator = true
            currencyFormatter.numberStyle = NumberFormatter.Style.currency
            currencyFormatter.locale = NSLocale.current
            self.budget = currencyFormatter.string(from: NSNumber(value: movie.budget))!
        }
    }

    private(set) var casts = [CastViewModel]()
    private(set) var title = ""
    private(set) var description = ""
    private(set) var year = ""
    private(set) var director = ""
    private(set) var writer = ""
    private(set) var budget = ""
    private(set) var image = ""

    public let movieId: Int
    
    init(withMovieId id: Int) {
        self.movieId = id
    }

    func pick (castId: Int) {
        self.steps.accept(DemoStep.castIsPicked(withId: castId))
    }
    
}
