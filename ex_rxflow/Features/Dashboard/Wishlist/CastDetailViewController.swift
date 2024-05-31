//
//  CastDetailViewController.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import Foundation
import UIKit
import Reusable

class CastDetailViewController: UIViewController, StoryboardBased, ViewModelBased {
    var viewModel: CastDetailViewModel!
    
    @IBOutlet private weak var castBanner: UIImageView!
    @IBOutlet private weak var castBio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.castBanner.image = UIImage(named: self.viewModel.image)
        self.castBio.text = self.viewModel.bio
    }
}
