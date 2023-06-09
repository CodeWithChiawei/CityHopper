//
//  LocationRequestViewController.swift
//  CityHopper
//
//  Created by chiawei wen on 4/26/23.
//

import Foundation
import CoreLocation
import UIKit

class LocationRequestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        LocationManager.shared.startLocation { [weak self] location in
            if location == nil {
                self?.presentTabBar()
            } else {
                self?.presentTabBar()
            }
        }
    }
    
    private func presentTabBar() {
        let tabBar = TabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.modalTransitionStyle = .crossDissolve
        self.present(tabBar, animated: true)
    }
}
