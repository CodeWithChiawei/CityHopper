//
//  ModelController.swift
//  CityHopper
//
//  Created by chiawei wen on 5/28/23.
//

import Foundation

enum CityUpdate {
    case willVisit(Bool)
    case didVisit(Bool)
    case isFavorited(Bool)
}

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
    
    func updateCity(city: City, for property: CityUpdate) {
        switch property {
        case .willVisit(let willVisit):
            city.willVisit = willVisit
        case .didVisit(let didVisit):
            city.didVisit = didVisit
        case .isFavorited(let isFavorited):
            city.isFavorited = isFavorited
        }
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
