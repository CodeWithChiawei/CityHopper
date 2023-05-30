//
//  CityProfileMapView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/13/23.
//

import Foundation
import UIKit
import MapboxMaps

class ProfileMapView: UIView {
    
    var globe: MapView!
    private lazy var viewAnnotation = globe.viewAnnotations
    private lazy var pointAnnotationManager = globe?.annotations.makePointAnnotationManager()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupGlobeInitialView()
        globeOrnamentConfig()
        clipsToBounds = true
        setConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGlobeInitialView() {
        let myResourceOptions = ResourceOptions(accessToken: APIToken.mapboxMapsToken)
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 90, longitude: 67), zoom: 1.05)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,cameraOptions: cameraOptions, styleURI: StyleURI(rawValue: MapStyleURI.flatMap.rawValue))
        self.globe = MapView(frame: .zero, mapInitOptions: myMapInitOptions)
        globe.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func globeOrnamentConfig() {
        globe.ornaments.scaleBarView.removeFromSuperview()
        globe.ornaments.logoView.removeFromSuperview()
        globe.ornaments.attributionButton.removeFromSuperview()
    }
    
    private func setConstraints() {
        addSubview(globe)
        globe.layer.cornerRadius = 50
        globe.topAnchor.constraint(equalTo: topAnchor).isActive = true
        globe.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        globe.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        globe.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setupMap(with latitude: Double, and longitude: Double) {
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoom: 7)
        globe.camera.fly(to: cameraOptions, duration: 2.5)
        setupPin(with: latitude, and: longitude)
    }
    
    private func setupPin( with latitude: Double, and longitude: Double) {
        self.pointAnnotationManager?.annotations.removeAll()
        var cityPointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        if let latitude = LocationManager.shared.latitude, let longitude = LocationManager.shared.longitude {
            var userPointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
            userPointAnnotation.image = .init(image: UIImage(named: "currentLocationPin")!, name: "currentLocationPin")
            pointAnnotationManager?.annotations.append(userPointAnnotation)
        }
        cityPointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        cityPointAnnotation.iconAnchor = .bottom
        pointAnnotationManager?.annotations.append(cityPointAnnotation)
    }

}
