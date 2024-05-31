//
//  AppFlow.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import RxFlow
import UIKit
import RxCocoa
import RxSwift

class AppFlow: Flow {
    func navigate(to step: RxFlow.Step) -> RxFlow.FlowContributors {
        guard let step = step as? DemoStep else { return .none }

                switch step {
                case .dashboardIsRequired:
                    return navigationToDashboardScreen()
                case .onboardingIsRequired:
                    return navigationToOnboardingScreen()
                case .onboardingIsComplete:
                    return self.dismissOnboarding()
                default:
                    return .none
                }
    }
    
    private func navigationToDashboardScreen() -> FlowContributors {
        let dashboardFlow = DashboardFlow(withServices: self.services)

        Flows.use(dashboardFlow, when: .created) { [unowned self] root in
            self.rootViewController.pushViewController(root, animated: false)
        }

        return .one(flowContributor: .contribute(withNextPresentable: dashboardFlow,
                                                         withNextStepper: OneStepper(withSingleStep: DemoStep.dashboardIsRequired)))
    }
    
    private func navigationToOnboardingScreen() -> FlowContributors {
        let onboardingFlow = OnboardingFlow(withServices: self.services)

        Flows.use(onboardingFlow, when: .created) { [unowned self] root in
            DispatchQueue.main.async {
                self.rootViewController.present(root, animated: true)
            }
        }

        return .one(flowContributor: .contribute(withNextPresentable: onboardingFlow,
                                                         withNextStepper: OneStepper(withSingleStep: DemoStep.loginIsRequired)))
    }
    private func dismissOnboarding() -> FlowContributors {
        if let onboardingViewController = self.rootViewController.presentedViewController {
            onboardingViewController.dismiss(animated: true)
        }
        return .none
    }
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return viewController
    }()
    
    private let services: AppServices

    init(services: AppServices) {
        self.services = services
    }

    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    
}

class AppStepper: Stepper {

    let steps = PublishRelay<Step>()
    private let appServices: AppServices
    private let disposeBag = DisposeBag()

    init(withServices services: AppServices) {
        self.appServices = services
    }

    var initialStep: Step {
        return DemoStep.dashboardIsRequired
    }

    /// callback used to emit steps once the FlowCoordinator is ready to listen to them to contribute to the Flow
    func readyToEmitSteps() {
        self.appServices
            .preferencesService.rx
            .isOnboarded
            .map { $0 ? DemoStep.onboardingIsComplete : DemoStep.onboardingIsRequired }
            .bind(to: self.steps)
            .disposed(by: self.disposeBag)
    }
}
