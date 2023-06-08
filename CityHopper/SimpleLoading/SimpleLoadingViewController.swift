//
//  LoadingScreen.swift
//  CityHopper
//
//  Created by chiawei wen on 4/16/23.
//
import Foundation
import UIKit

class SimpleLoadingViewController: UIViewController {
    
    private let contentView = SimpleLoadingView()
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.loadingAnimation()
    }
}
