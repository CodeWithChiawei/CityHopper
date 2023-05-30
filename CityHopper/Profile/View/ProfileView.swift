//
//  CityUpdateView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//

import Foundation
import UIKit

class ProfileView: UIView {
    
    let containerView = ProfileContainerView()
    private let mapView = ProfileMapView()
    
    let backToProfileButton: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.backward.circle")
        imageView.isUserInteractionEnabled = true
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let blurEffiectView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        view.effect = blurEffect
        return view
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 33, weight: .medium)
        label.backgroundColor = .clear
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        backToProfileButton.isHidden = true
        setConstraint()
        addBlurEffect()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        addSubview(backToProfileButton)
        addSubview(cityLabel)
        addSubview(containerView)
        addSubview(mapView)
        
        backToProfileButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        backToProfileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        backToProfileButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        backToProfileButton.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        containerView.layer.cornerRadius = 50
        containerView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 530).isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        
        mapView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/1.5).isActive = true
        
        cityLabel.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -2).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func addBlurEffect() {
        blurEffiectView.frame = bounds
        blurEffiectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurEffiectView, at: 0)
    }
    
    func configView() {
        cityLabel.isHidden = true
        mapView.isHidden = true
        containerView.isHidden = false
    }
    
    func changeToMapView(cityData: City) {
        containerView.isHidden = true
        cityLabel.text = cityData.name
        cityLabel.isHidden = false
        mapView.isHidden = false
        backToProfileButton.isHidden = false
        mapView.setupMap(with: cityData.latitude, and: cityData.longitude)
    }
    
    func backtoContainerView() {
        containerView.isHidden = false
        mapView.isHidden = true
        cityLabel.isHidden = true
        backToProfileButton.isHidden = true
    }
}
