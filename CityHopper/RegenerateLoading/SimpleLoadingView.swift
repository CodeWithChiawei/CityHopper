//
//  SimpleLoadingView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/17/23.
//

import Foundation
import UIKit

class SimpleLoadingView: UIView {
    
    private let imageView = UIImageView(image: UIImage(named: "loadingGlobe"))

    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func loadingAnimation() {
        let  rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 1.0)
        rotationAnimation.duration = 0.75
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity

        // Add the animation to the image view's layer
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
