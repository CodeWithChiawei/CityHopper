//
//  LoadingScreen.swift
//  CityHopper
//
//  Created by chiawei wen on 4/16/23.
//
import Foundation
import UIKit

class RegenerateLoadingViewController: UIViewController {
    
    private let contentView = RegenerateLoadingView()
    var isVisited = Bool()
    var city: String? = ""
    
    override func loadView() {
         view = contentView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.setLabel(cityName: city ?? "", visited: isVisited)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.roatateAnimation()
    }
}
