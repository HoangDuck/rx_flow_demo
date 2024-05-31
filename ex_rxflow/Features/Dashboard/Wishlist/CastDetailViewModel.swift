//
//  CastDetailViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation

class CastDetailViewModel: ServicesViewModel {
    typealias Services = HasMoviesService
    var services: Services! {
           didSet {
               let cast = self.services.moviesService.cast(forId: castId)
               self.name = cast.name
               self.image = cast.image
               self.bio = cast.bio
           }
       }

       private(set) var name = ""
       private(set) var image = ""
       private(set) var bio = ""

       public let castId: Int

       init(withCastId id: Int) {
           self.castId = id
       }
}
