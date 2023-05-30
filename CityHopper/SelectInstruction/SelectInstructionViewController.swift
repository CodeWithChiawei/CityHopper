//
//  CitySelectionInstruction.swift
//  CityHopper
//
//  Created by chiawei wen on 5/15/23.
//

import Foundation
import UIKit

class SelectInstructionViewController: UIViewController {
    
    private var pageCount = 1
    private let contentView = SelectInstructionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = contentView
        contentView.nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func nextButtonTapped() {
        pageCount += 1
        contentView.viewConfig(with: pageCount)
        if pageCount >= 5 {
            dismiss(animated: false)
        }
    }
}
