
import Foundation
import UIKit
import MapboxMaps

class ExploreGlobeView: UIView {
    
    var globe: MapView?
    private var camera: CameraOptions?
    private var completionHandler: (() -> Void)?
    private var timer: Timer?
    private var currentBearing: CLLocationDirection = 0
    private var currentLongitude: Double = 0
    private var selectedLongitude: Double = 0
    private var currentLatitude: Double = 0
    private var currentZoom: Double = 1.9
    private var displayLink: CADisplayLink?
    private var didPresent: Bool = false
    private var isFirstTimeUser: Bool = true
    lazy var userPointAnnotationManager = globe?.annotations.makePointAnnotationManager()
    lazy var cityPointAnnotationManager = globe?.annotations.makePointAnnotationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGlobeInitialView()
        observeUserDefaults()
        setConstraint()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func observeUserDefaults() {
        NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: .main) { [weak self] _ in
            if let selectedContinent = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCellContinent.rawValue) {
                self?.setMapCamera(with: selectedContinent)
            }
        }
    }
    
    private func setupGlobeInitialView() {
        let myResourceOptions = ResourceOptions(accessToken: APIToken.mapboxMapsToken)
        let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 0, longitude: currentLongitude), zoom: 0.85)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions,
                                              cameraOptions: cameraOptions,
                                              styleURI: StyleURI(rawValue: MapStyleURI.sateliteGlobe.rawValue)
        )
        self.globe = MapView(frame: .zero, mapInitOptions: myMapInitOptions)
        globe?.translatesAutoresizingMaskIntoConstraints = false
        globe?.isUserInteractionEnabled = false
        globeOrnamentsConfig()
    }
    
    private func globeOrnamentsConfig() {
        globe?.ornaments.attributionButton.removeFromSuperview()
        globe?.ornaments.scaleBarView.removeFromSuperview()
        globe?.ornaments.compassView.removeFromSuperview()
        globe?.ornaments.logoView.removeFromSuperview()
    }
    
    private func setConstraint() {
        addSubview(globe ?? MapView())
        globe?.translatesAutoresizingMaskIntoConstraints = false
        globe?.topAnchor.constraint(equalTo: topAnchor).isActive = true
        globe?.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        globe?.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        globe?.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    func startDisplayGlobeSpin() {
        didPresent = false
        if isFirstTimeUser {
            currentLongitude = LocationManager.shared.currentLocation?.coordinate.longitude ?? 0
            isFirstTimeUser = false
        } else {
            currentLongitude = selectedLongitude
        }
        globe?.camera.fly(to: CameraOptions(center: CLLocationCoordinate2D(latitude: 0, longitude: currentLongitude), zoom: 0.85, bearing: 0), duration: 1) { [weak self] _ in
            self?.displayLink?.invalidate()
            self?.displayLink = CADisplayLink(target: self, selector: #selector(self?.spinTheGlobe))
            self?.displayLink?.add(to: .main, forMode: .common)
        }
    }
    
    
    @objc
    private func spinTheGlobe() {
        if currentLongitude > 360 {
            currentLongitude = 360
        }else if currentLongitude < -360 {
            currentLongitude = 0
        }
        currentLongitude -= 0.20
        let camera = CameraOptions(center: CLLocationCoordinate2D(
            latitude: 0, longitude: currentLongitude), zoom: 0.85, bearing: 0
        )
        globe?.mapboxMap.setCamera(to: camera)
        selectedLongitude = currentLongitude
    }
    
    func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
        currentBearing = 0
    }
    
    private func setMapCamera(with continent: String) {
        switch continent {
        case "Asia":
            configureCamera(with: 35, longitude: 95, isAntarctica: false)
        case "North America":
            configureCamera(with: 47, longitude: -93, isAntarctica: false)
        case "South America":
            configureCamera(with: -8, longitude: -75, isAntarctica: false)
        case "Oceania":
            configureCamera(with: -26, longitude: 146, isAntarctica: false)
        case "Europe":
            configureCamera(with: 50, longitude: 14, isAntarctica: false)
        case "Antarctica":
            configureCamera(with: -80, longitude: -58, isAntarctica: true)
        case "Africa":
            configureCamera(with: 6, longitude: 21, isAntarctica: false)
        default:
            self.camera = CameraOptions(center: CLLocationCoordinate2D(latitude: 90, longitude: 67), zoom: 1.0)
            globe?.mapboxMap.setCamera(to: camera!)
        }
    }
    
    private func configureCamera(with latitude: Double, longitude: Double, isAntarctica: Bool) {
        
        self.camera = CameraOptions(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoom: checkIsAntarctica(), bearing: 0)
        globe?.camera.ease(to: self.camera!, duration: 0.4)
        stopDisplayLink()
        func checkIsAntarctica() -> Double {
            if isAntarctica {
                return 1.9
            } else {
                return 1.2
            }
        }
        self.currentLongitude = longitude
        self.selectedLongitude = latitude
    }
    
    func setUserLocationPin( with latitude: Double, and longitude: Double) {
        var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        self.userPointAnnotationManager?.annotations.removeAll()
        pointAnnotation.image = .init(image: UIImage(named: "currentLocationPin")!, name: "currentLocationPin")
        pointAnnotation.iconAnchor = .bottom
        userPointAnnotationManager?.annotations = [pointAnnotation]
    }
    
    func setCityPin( with latitude: Double, and longitude: Double) {
        var pointAnnotation = PointAnnotation(coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
        self.cityPointAnnotationManager?.annotations.removeAll()
        pointAnnotation.image = .init(image: UIImage(named: "red_pin")!, name: "red_pin")
        pointAnnotation.iconAnchor = .bottom
        cityPointAnnotationManager?.annotations = [pointAnnotation]
    }
}




