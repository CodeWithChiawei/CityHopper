//
//  RegenerateLoadingView.swift
//  CityHopper
//
//  Created by chiawei wen on 5/17/23.
//

import Foundation
import UIKit

class RegenerateLoadingView: UIView {
    
    private let loadingGlobeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "loadingGlobe")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let addToFutureLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let addToVisitedLabel: UILabel = {
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
    
    private let blurEffectView: UIVisualEffectView = {
        var blurEffectView = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    private let dimView: UIView = {
        let dimView = UIView()
        dimView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
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
        addSubview(blurEffectView)
        addSubview(dimView)
        addSubview(loadingGlobeImageView)
        addSubview(addToFutureLabel)
        addSubview(nextCityLabel)
        addSubview(addToVisitedLabel)
        
        blurEffectView.frame = bounds
        dimView.frame = bounds
        
        loadingGlobeImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loadingGlobeImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loadingGlobeImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        loadingGlobeImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        addToFutureLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        addToFutureLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        addToFutureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        addToFutureLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        addToVisitedLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 80).isActive = true
        addToVisitedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        addToVisitedLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
        addToVisitedLabel.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nextCityLabel.topAnchor.constraint(equalTo: addToFutureLabel.bottomAnchor, constant: 10).isActive = true
        nextCityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        nextCityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func roatateAnimation() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = NSNumber(value: Double.pi * 1.0)
        rotationAnimation.duration = 0.75
        rotationAnimation.isCumulative = true
        rotationAnimation.repeatCount = .infinity
        
        loadingGlobeImageView.layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
    
    func setLabel(cityName: String = "", visited: Bool) {
        if cityName == "" {
            addToFutureLabel.isHidden = true
            addToVisitedLabel.isHidden = true
        } else if visited == true {
            addToFutureLabel.isHidden = true
            addToVisitedLabel.isHidden = false
            addToVisitedLabel.text = "\(cityName) has been added \n to your visited list"
        } else if visited != true {
            addToFutureLabel.text = "\(cityName) has been added \n to your future destination"
        }
    }
}
