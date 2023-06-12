//
//  Extension.swift
//  CityHopper
//
//  Created by chiawei wen on 6/8/23.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
}


extension UIButton {
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
}

extension UISegmentedControl {
    func addShadow() {
        layer.masksToBounds = false
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        clipsToBounds = false
    }
    
    static func create(withItems items: [String], selectedIndex: Int) -> UISegmentedControl {
            let segmentedControl = UISegmentedControl(items: items)
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            segmentedControl.setTitleTextAttributes(attributes, for: .normal)
            segmentedControl.translatesAutoresizingMaskIntoConstraints = false
            segmentedControl.selectedSegmentIndex = selectedIndex
            segmentedControl.backgroundColor = .darkGray
            segmentedControl.selectedSegmentTintColor = .systemBlue
            return segmentedControl
        }
}

