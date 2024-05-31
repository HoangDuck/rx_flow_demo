//
//  TrendingViewController.swift
//  ex_rxflow
//
//  Created by TE-Member on 31/05/2024.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

class TrendingViewController: UIViewController, StoryboardBased, ViewModelBased{
    typealias ViewModelType = TrendingViewModel
    
    var viewModel: TrendingViewModel!
    
    var nestedViewControllers = [UIViewController]()
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak var tabSegmentedControl: UISegmentedControl!
    
    private lazy var pageViewController: UIPageViewController = {
        let page = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal,options: [:])
        page.view.translatesAutoresizingMaskIntoConstraints = false
        page.delegate = self
        page.dataSource = self
        return page
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        
        
    }
    
    private func bind(){
        tabSegmentedControl.rx.selectedSegmentIndex
                    .asDriver()
                    .drive { [weak self] selectedIndex in
                        self?.selectSegmentWith(selectedIndex: selectedIndex)
                    }
                    .disposed(by: disposeBag)
    }
    
    private func selectSegmentWith(selectedIndex: Int) {
            guard let currentViewController = pageViewController.viewControllers?.first,
                let index = nestedViewControllers.firstIndex(of: currentViewController),
                index != selectedIndex,
                nestedViewControllers.count > selectedIndex else {
                    return
            }

            let selectedViewController = nestedViewControllers[selectedIndex]
            pageViewController.setViewControllers([selectedViewController], direction: .forward, animated: false, completion: nil)
        }
    
    private func layout(){
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        NSLayoutConstraint.activate([pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                           pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                           pageViewController.view.topAnchor.constraint(equalTo: tabSegmentedControl.bottomAnchor, constant: 16),
                                           pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        pageViewController.didMove(toParent: self)
    }
    
}

extension TrendingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
            let currentViewController = pageViewController.viewControllers?.first,
            let index = nestedViewControllers.firstIndex(of: currentViewController) else {
            return
        }
        tabSegmentedControl.selectedSegmentIndex = index
    }
}

extension TrendingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = nestedViewControllers.firstIndex(of: viewController), index > 0 else {return nil}
        return nestedViewControllers[index-1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = nestedViewControllers.firstIndex(of: viewController), index < nestedViewControllers.count - 1 else { return nil }
        return nestedViewControllers[index+1]
    }
}
