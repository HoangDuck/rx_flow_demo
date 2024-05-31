//
//  SettingsLoginViewController.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa
import RxFlow

class SettingsLoginViewController: UIViewController, StoryboardBased, Stepper {

    @IBOutlet weak var proceedButton: UIButton!

    let steps = PublishRelay<Step>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _ = proceedButton.rx.tap
            .take(until: self.rx.deallocating)
            .map { DemoStep.userIsLoggedIn }
            .bind(to: self.steps)
    }

}
