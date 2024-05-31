//
//  SettingsViewController.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import UIKit
import Reusable
import RxFlow
import RxSwift
import RxCocoa

class SettingsListViewController: UITableViewController, StoryboardBased, Stepper {

    let steps = PublishRelay<Step>()

    struct SettingItem {
        let step: DemoStep
        let title: String
    }

    let settings = [
        SettingItem(step: .loginIsRequired, title: "Login"),
        SettingItem(step: .apiKeyIsRequired, title: "API Key"),
        SettingItem(step: .aboutIsRequired, title: "About")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        _ = Observable.of(settings)
            .take(until: self.rx.deallocating)
            .bind(to: tableView.rx.items(cellIdentifier: "SettingCell")) { _, element, cell in
                cell.textLabel?.text = element.title
        }

        _ = tableView.rx.modelSelected(SettingItem.self)
            .take(until: self.rx.deallocating)
            .map { $0.step }
            .bind(to: self.steps)
    }
}
