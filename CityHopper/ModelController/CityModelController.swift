//
//  ModelController.swift
//  CityHopper
//
//  Created by chiawei wen on 5/28/23.
//

import Foundation

class CityModelController {
    
    static let shared = CityModelController()
    private init() {}
    
    private let context = CoreDataStack.context
    var exploreCity: FetchCityModel?
    var cities = [City]()
    var profileCity: City?
    
    func retrieveData(completion: @escaping () -> Void) {
        do {
            cities = try context.fetch(CityCoreData.fetchCity())
            DispatchQueue.main.async {
                completion()
            }
        } catch {
            print("Error Fetching CoreData: \(error)")
        }
    }
    
    func createCity(with name: String,
                    countryCode: String,
                    latitude: Double,
                    longitude: Double,
                    willVisit: Bool,
                    didVisit: Bool,
                    isFavorited: Bool) {
        let newCity = City(context: context)
        newCity.name = name
        newCity.countryCode = countryCode
        newCity.latitude = latitude
        newCity.longitude = longitude
        newCity.willVisit = willVisit
        newCity.didVisit = didVisit
        newCity.isFavorited = isFavorited
        saveData()
    }
    
    func updateCityWillVisit(city: City, willVisit: Bool) {
        city.willVisit = willVisit
        saveData()
    }
    
    func updateCityIDidVisit(city: City, didVisit: Bool) {
        city.didVisit = didVisit
        saveData()
    }
    
    func updateCityIsFavorited(city: City, isFavorited: Bool) {
        city.isFavorited = isFavorited
        saveData()
    }
    
    func updateCityIsGoing(city: City, willVisit: Bool) {
        city.willVisit = willVisit
        saveData()
     }
    
    func updateCityisVisited(city: City, didVisit: Bool) {
        city.didVisit = didVisit
        saveData()
    }
    
    func deleteCity(city: City) {
        if city.willVisit == false && city.didVisit == false {
            context.delete(city)
            saveData()
        }
    }
    
    func saveData() {
        do {
            try context.save()
        } catch {
            print("ERROR Saving CoreData: \(error)")
        }
    }
}
