//
//  TrendingViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class TrendingViewModel: ViewModel, Stepper {
    let steps = PublishRelay<Step>()
}
