//
//  CityLotteryView.swift
//  TripCity
//
//  Created by chiawei wen on 3/11/23.
//

import Foundation
import UIKit
import MapboxMaps

class SelectView: UIView {
    
    var mapView: MapView?
    var mapCamera: CameraOptions?
    lazy var pointAnnotationManager = mapView?.annotations.makePointAnnotationManager()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "cityPickBackGround")
        imageView.layer.zPosition = -1
        return imageView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 31, weight: .medium)
        label.textAlignment = .center
        label.text = "City"
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
     let addToFutureVisitButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "suitcase.rolling.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 39
        button.addShadow()
        return button
    }()
    
     let addToVisitedButton: UIButton = {
           let button = UIButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           let image = UIImage (
               systemName: "mappin.and.ellipse",
               withConfiguration: UIImage.SymbolConfiguration(
                   pointSize: UIFont.systemFont(ofSize: 45).pointSize, weight: .regular)
           )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
           button.setImage(image, for: .normal)
           button.backgroundColor = .white
           button.layer.cornerRadius = 39
           button.addShadow()
           return button
       }()
    
     let regenerateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "arrow.counterclockwise",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 30
        button.addShadow()
        return button
    }()
    
   
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage (
            systemName: "house.fill",
            withConfiguration: UIImage.SymbolConfiguration(
                pointSize: UIFont.systemFont(ofSize: 35).pointSize, weight: .regular)
        )?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.backgroundColor = .white
        button.isUserInteractionEnabled = true
        button.layer.cornerRadius = 30
        button.addShadow()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraint()
        cityMapConfigures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraint() {
        
        let myResourceOptions = ResourceOptions(accessToken: APIToken.mapboxMapsToken)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,cameraOptions: CameraOptions(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), zoom: 7), styleURI: StyleURI(rawValue: MapStyleURI.cityPickMap.rawValue))
        self.mapView = MapView(frame: .zero, mapInitOptions: myMapInitOptions)
        
        insertSubview(backgroundImageView, at: 0)
        addSubview(cityLabel)
        addSubview(addToFutureVisitButton)
        addSubview(mapView ?? MapView())
        addSubview(backButton)
        addSubview(regenerateButton)
        addSubview(addToVisitedButton)
        
        backgroundImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 15).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 95).isActive = true
        
        mapView?.isUserInteractionEnabled = false
        mapView?.translatesAutoresizingMaskIntoConstraints = false
        mapView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mapView?.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10).isActive = true
        mapView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        mapView?.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
//        cityMap?.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/2).isActive = true
        mapView?.bottomAnchor.constraint(equalTo: addToFutureVisitButton.topAnchor, constant: -40).isActive = true
        mapView?.layer.cornerRadius = 25
        mapView?.clipsToBounds = true
        
        regenerateButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        regenerateButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 45).isActive = true
        regenerateButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        regenerateButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        backButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -40).isActive = true
        backButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -45).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        addToFutureVisitButton.trailingAnchor.constraint(equalTo: backButton.leadingAnchor, constant: -15).isActive = true
        addToFutureVisitButton.topAnchor.constraint(equalTo: backButton.topAnchor, constant: -40).isActive = true
        addToFutureVisitButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        addToFutureVisitButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
        addToVisitedButton.leadingAnchor.constraint(equalTo: regenerateButton.trailingAnchor, constant: 15).isActive = true
        addToVisitedButton.centerYAnchor.constraint(equalTo: addToFutureVisitButton.centerYAnchor).isActive = true
        addToVisitedButton.heightAnchor.constraint(equalToConstant: 78).isActive = true
        addToVisitedButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        
    }
    
    private func cityMapConfigures() {
        mapView?.ornaments.scaleBarView.removeFromSuperview()
        mapView?.ornaments.compassView.removeFromSuperview()
        mapView?.ornaments.logoView.removeFromSuperview()
        mapView?.ornaments.attributionButton.removeFromSuperview()
        mapView?.layer.borderColor = UIColor.black.cgColor
        mapView?.layer.borderWidth = 2
        mapView?.isUserInteractionEnabled = false
    }
    
    func setupMap(with latitude: Double, and longitude: Double) {
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoom: 1.5)
        mapView?.mapboxMap.setCamera(to: cameraOptions)
        setupPin(with: latitude, and: longitude)
    }
    
    private func setupPin( with latitude: Double, and longitude: Double) {
        self.pointAnnotationManager?.annotations.removeAll()
        var cityPointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        if let userLatitdue = LocationManager.shared.latitude, let userLongitude = LocationManager.shared.longitude {
            var userPointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: userLatitdue, longitude: userLongitude))
            userPointAnnotation.image = .init(image: UIImage(named: "currentLocationPin")!, name: "currentLocationPin")
            pointAnnotationManager?.annotations.append(userPointAnnotation)
        }
        cityPointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        cityPointAnnotation.iconAnchor = .bottom
        
        pointAnnotationManager?.annotations.append(cityPointAnnotation)
    }
    
    func configure(with city: String, and countryCode: String) {
        if let countryName = Locale.current.localizedString(forRegionCode: countryCode) {
            self.cityLabel.text = "\(city.capitalized)\n\(countryName)"
        } else {
            self.cityLabel.text = "\(city.capitalized)\n\(countryCode)"
        }
    }
}
