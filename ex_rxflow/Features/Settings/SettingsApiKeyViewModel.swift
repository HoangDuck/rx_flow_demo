//
//  SettingsApiKeyViewModel.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxFlow
import RxSwift
import RxCocoa

class SettingsApiKeyViewModel: Stepper, ServicesViewModel {

    let steps = PublishRelay<Step>()
    typealias Services = HasPreferencesService

    var services: Services!

    func setApiKey() {
        self.services.preferencesService.setOnboarded()
    }
}
