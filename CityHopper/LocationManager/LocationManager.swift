//
//  LocationManager.swift
//  CityHopper
//
//  Created by chiawei wen on 4/26/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    
    
    let locationManager = CLLocationManager()
    var locationUpdateCompletion: ((CLLocation?) -> Void)?
    var currentLocation: CLLocation?
    lazy var latitude = currentLocation?.coordinate.latitude
    lazy var longitude = currentLocation?.coordinate.longitude
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        locationUpdateCompletion?(location)
        locationUpdateCompletion = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdatingLocation()
        case .denied, .restricted:
            locationUpdateCompletion?(nil)
            locationUpdateCompletion = nil
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location update failed: \(error.localizedDescription)")
    }
    
    func startLocation(completion: @escaping (CLLocation?) -> Void) {
        locationUpdateCompletion = completion
        requestLocationAuthorization()
        startUpdatingLocation()
    }
}
