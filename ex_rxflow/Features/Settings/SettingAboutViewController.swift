//
//  SettingAboutViewController.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import UIKit
import Reusable
import RxFlow
import RxCocoa

class SettingsAboutViewController: UIViewController, StoryboardBased, Stepper {

    let steps = PublishRelay<Step>()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func done(_ sender: UIButton) {
        self.steps.accept(DemoStep.aboutIsComplete)
    }
}
