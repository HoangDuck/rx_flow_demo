//
//  CastsService.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation

protocol HasCastsService {
    var castsService: CastsService { get }
}

class CastsService {
    func allCasts() -> [Cast] {
        CastsRepository.casts
    }
}
