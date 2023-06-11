//
//  CityPickViewModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/29/23.
//

import Foundation

class GeneratedCityViewModel {
    
    private let networkManager = NetworkManager()
    var generatedCityModelData: GeneratedCityModel?
    var city: City?
    
    func assignCityModelData () {
        guard let city = CityModelController.shared.exploreCity else { return }
        self.generatedCityModelData = GeneratedCityModel(
            cityName: city.name,
            countryCode: city.countryCode,
            latitude: city.latitude,
            longitude: city.longitude)
    }
    
    func fetchCity(completion: @escaping (Result<FetchCityModel, Error>) -> Void) {
        guard let continent = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCellContinent.rawValue) else { return }
        networkManager.fetchCountryJSON(with: continent) {  result in
            DispatchQueue.main.async {
                switch result {
                case .success(let city):
                    completion(.success(city))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func assignCity(newCity: GeneratedCityModel) {
        if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == newCity.latitude && $0.longitude == newCity.longitude }) {
            city = existingCity
        } else {
            networkManager.fetchFlagImageData(with: newCity.countryCode) { [weak self] data in
                self?.city = City(context: CoreDataStack.context)
                self?.city?.name = newCity.cityName
                self?.city?.countryCode = newCity.countryCode
                self?.city?.latitude = newCity.latitude
                self?.city?.longitude = newCity.longitude
                self?.city?.isFavorited = false
                self?.city?.willVisit = false
                self?.city?.didVisit = false
                self?.city?.image = data
                CityModelController.shared.saveData()
            }
        }
    }
}
