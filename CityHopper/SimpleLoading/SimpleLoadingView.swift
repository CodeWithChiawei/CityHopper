//
//  SimpleLoadingView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/17/23.
//

import Foundation
import UIKit

class SimpleLoadingView: UIView {
    
    private let loadingGlobeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadingGlobe")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dimView: UIView = {
        let dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.25)
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return dimView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        addSubview(dimView)
        addSubview(loadingGlobeImageView)
        
        dimView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        dimView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        dimView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        dimView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        loadingGlobeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingGlobeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingGlobeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingGlobeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func loadingAnimation() {
        let  rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 1.0)
        rotationAnimation.duration = 0.75
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity

        loadingGlobeImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
}
