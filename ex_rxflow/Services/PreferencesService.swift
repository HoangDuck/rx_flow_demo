//
//  PreferencesService.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxSwift

protocol HasPreferencesService {
    var preferencesService: PreferencesService { get }
}
/// Represents the keys that are used to store user defaults
struct UserPreferences {
    private init () {}

    /// key for onBoarded preference
    static let onBoarded = "onBoarded"
}

class PreferencesService {
    /// sets the onBoarded preference to true
    func setOnboarded() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: UserPreferences.onBoarded)
    }
    
    /// removes the onBoarded preference
    func notSetOnboarded() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: UserPreferences.onBoarded)
    }
    
    /// Returns true if the user has already onboarded, false otherwise
    ///
    /// - Returns: true if the user has already onboarded, false otherwise
    func isOnBoarded() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: UserPreferences.onBoarded)
    }
}

extension PreferencesService: ReactiveCompatible {}


extension Reactive where Base: PreferencesService {
    var isOnboarded: Observable<Bool> {
        return UserDefaults.standard
            .rx
            .observe(Bool.self, UserPreferences.onBoarded)
            .map { $0 ?? false }
    }
}
