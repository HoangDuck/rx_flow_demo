//
//  CastListViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxFlow
import RxCocoa
import RxSwift

class CastListViewModel: ServicesViewModel, Stepper {
    
    typealias Services = HasCastsService
    
    private(set) var casts: [CastViewModel]
    
    let steps = PublishRelay<Step>()
    
    var services: Services! {
        didSet {
            self.casts = self.services.castsService.allCasts().map({ (cast) -> CastViewModel in
                return CastViewModel(id: cast.id, name: cast.name, image: cast.image)
            })
        }
    }
    
    init() {
        self.casts = [CastViewModel]()
    }

    public func pick(castId: Int) {
        self.steps.accept(DemoStep.castIsPicked(withId: castId))
    }
}

