//
//  RegenerateLoadingView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/17/23.
//

import Foundation
import UIKit

class RegenerateLoadingView: UIView {
    
    private let imageView = UIImageView(image: UIImage(named: "loadingGlobe"))
    
    private let saveToFutureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let saveToVisitedLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let nextCityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25, weight: .regular)
        label.textAlignment = .center
        label.text = "Looking For Next Destination!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        var blurEffectView: UIVisualEffectView!
        var dimView: UIView!
        
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimView.frame = bounds
        dimView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(dimView)
        
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func constraint() {
        
        addSubview(imageView)
        addSubview(saveToFutureLabel)
        addSubview(nextCityLabel)
        addSubview(saveToVisitedLabel)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        saveToFutureLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        saveToFutureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        saveToFutureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        saveToFutureLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        saveToVisitedLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        saveToVisitedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        saveToVisitedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        saveToVisitedLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nextCityLabel.topAnchor.constraint(equalTo: saveToFutureLabel.bottomAnchor, constant: 10).isActive = true
        nextCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nextCityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func roatateAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 1.0)
        rotationAnimation.duration = 0.75
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        
        imageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func setLabel(cityName: String, visited: Bool) {
        if cityName == "" {
            saveToFutureLabel.isHidden = true
            saveToVisitedLabel.isHidden = true
        } else if visited == true {
            saveToFutureLabel.isHidden = true
            saveToVisitedLabel.isHidden = false
            saveToVisitedLabel.text = "\(cityName) has been added \n to your visited list"
        } else if visited != true {
            saveToFutureLabel.text = "\(cityName) has been added \n to your future destination"
        }
    }
}
