//
//  DemoStep.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//
import RxFlow

enum DemoStep: Step {
    // Global
    case logoutIsRequired
    case dashboardIsRequired
    case alert(String)
    case fakeStep
    case unauthorized

    // Login
    case loginIsRequired
    case userIsLoggedIn

    // Api Key
    case apiKeyIsRequired
    case apiKeyIsFilledIn

    // Onboarding
    case onboardingIsRequired
    case onboardingIsComplete

    // Movies
    case moviesAreRequired
    case movieIsPicked (withId: Int)
    case castIsPicked (withId: Int)

    // Settings
    case settingsAreRequired
    case settingsAreComplete

    // About
    case aboutIsRequired
    case aboutIsComplete

    // Trending
    case trendingsAreRequired

    // Cast List
    case castListAreRequired
}
