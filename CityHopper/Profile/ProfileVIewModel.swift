//
//  CityProfileVIewModel.swift
//  CityHopper
//
//  Created by chiawei wen on 4/12/23.
//

import Foundation

class ProfileViewModel {
    
    var city: City?
    
    func updateCity() {
        guard let city = city else { return }
        CityModelController.shared.updateCity(city: city, for: .didVisit(city.didVisit))
        CityModelController.shared.updateCity(city: city, for: .willVisit(city.willVisit))
    }  
}

