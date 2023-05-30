//
//  SegmentMapView.swift
//  CityHopper
//
//  Created by chiawei wen on 4/6/23.
//
import Foundation
import UIKit
import MapboxMaps


class SavedCityMapView: UIView, AnnotationInteractionDelegate {
    
    var globe: MapView!
    private lazy var annotationManager = globe.annotations.makePointAnnotationManager()
    private lazy var viewAnnotation = globe.viewAnnotations
    var selectedIndex: Int = 0
    
    private let callOutView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.3
        view.layer.shadowRadius = 4
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGlobeInitialView()
        setConstraints()
        globeOrnamentsConfig()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(screenTapped))
        globe.addGestureRecognizer(tapGesture)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let globeGesture = UIGestureRecognizer(target: self, action: #selector(globeTapped))
        globe.addGestureRecognizer(globeGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func screenTapped(_ gestureRecognizer: UITapGestureRecognizer) {
        viewAnnotation?.removeAll()
    }
    
    @objc
    private func globeTapped() {
        viewAnnotation?.removeAll()
    }
    
    private func setupGlobeInitialView() {
        let myResourceOptions = ResourceOptions(accessToken: APIToken.mapboxMapsToken)
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 90, longitude: 67), zoom: 1.05)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,cameraOptions: cameraOptions, styleURI: StyleURI(rawValue: MapStyleURI.flatMap.rawValue))
        self.globe = MapView(frame: .zero, mapInitOptions: myMapInitOptions)
        
    }
    
    private func globeOrnamentsConfig() {
        globe.ornaments.scaleBarView.removeFromSuperview()
        globe.ornaments.logoView.removeFromSuperview()
        globe.ornaments.attributionButton.removeFromSuperview()
    }
    
    private func setConstraints() {
        addSubview(globe)
        globe.gestures.options.rotateEnabled = false
        globe.translatesAutoresizingMaskIntoConstraints = false
        globe.topAnchor.constraint(equalTo: topAnchor).isActive = true
        globe.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        globe.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        globe.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func setPins(with cities: [City]) {
        
        annotationManager.delegate = self
        annotationManager.annotations.removeAll()
        
        if let userLatitdue = LocationManager.shared.latitude, let userLongitude = LocationManager.shared.longitude {
            var userPointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: userLatitdue, longitude: userLongitude))
            userPointAnnotation.image = .init(image: UIImage(named: "currentLocationPin")!, name: "currentLocationPin")
            userPointAnnotation.textField = ""
            self.annotationManager.annotations.append(userPointAnnotation)
        }
        
        for cityLocation in cities {
            var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: cityLocation.latitude, longitude: cityLocation.longitude))
            if selectedIndex == 0 {
                pointAnnotation.image = .init(image: UIImage(named: "planePin")!, name: "planePin")
                pointAnnotation.iconAnchor = .bottom
            } else if selectedIndex == 1 {
                pointAnnotation.image = .init(image: UIImage(named: "greenCheck")!, name: "greenCehck")
                pointAnnotation.iconAnchor = .bottom
                
            } else if selectedIndex == 2 {
                pointAnnotation.image = .init(image: UIImage(named: "whiteHeart")!, name: "whiteHeart")
                pointAnnotation.iconAnchor = .bottom
            }
            
            guard let city = cityLocation.name, let countryCode = cityLocation.countryCode else { return }
            pointAnnotation.textField = ("\(city), \(countryCode)")
            pointAnnotation.textSize = 11
            pointAnnotation.textHaloColor = StyleColor.init(UIColor.clear)
            pointAnnotation.textColor = StyleColor.init(UIColor.clear)
            annotationManager.annotations.append(pointAnnotation)
        }
    }
    
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        
        viewAnnotation?.removeAll()
        
        let annotation = annotations[0]
        guard let pointAnnotation = annotation as? PointAnnotation else { return }
        
        callOutView.frame = CGRect(x: 0, y: 0, width: ((pointAnnotation.textField?.count ?? 20) * 7), height: 80)
        titleLabel.frame = CGRect(x: 0, y: 5, width: ((pointAnnotation.textField?.count ?? 20) * 7), height: 15)
        addSubview(self.callOutView)
        callOutView.addSubview(titleLabel)
        titleLabel.text = pointAnnotation.textField
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        
        
        let coordinates = pointAnnotation.point.coordinates
        let coordinate = CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        let options = ViewAnnotationOptions(
            geometry: Point(coordinate),
            width: CGFloat((pointAnnotation.textField?.count ?? 20) * 7),
            height: 25,
            allowOverlap: false,
            anchor: .bottom,
            offsetY: 33
        )
        if pointAnnotation.textField != "" {
            try? viewAnnotation?.add(self.callOutView, options: options)
        }
    }
    
    func removeAnnotation() {
        viewAnnotation?.removeAll()
    }
}
