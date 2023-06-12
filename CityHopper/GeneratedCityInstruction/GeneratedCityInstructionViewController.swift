//
//  CitySelectionInstruction.swift
//  CityHopper
//
//  Created by chiawei wen on 5/15/23.
//

import Foundation
import UIKit

class GeneratedCityInstructionViewController: UIViewController {
    
    private var instructionStep = 1
    private let contentView = GeneratedCityInstructionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func nextButtonTapped() {
        instructionStep += 1
        contentView.viewConfig(with: instructionStep)
        if instructionStep >= 5 {
            dismiss(animated: false)
        }
    }
}
