//
//  InstructionViewController.swift
//  CityHopper
//
//  Created by chiawei wen on 4/19/23.
//

import Foundation
import UIKit

class InstructionViewController: UIViewController {
    
     private let contentView = InstructionView()
    
    override func loadView() {
        view = contentView
    }
}
