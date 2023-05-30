//
//  CityPickViewModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/29/23.
//

import Foundation

class SelectViewModel {
    
    private let networkManager = NetworkManager()
    var cityModelData: SelectedCityModel?
    var cityData: City?
    
    func assignCityModelData () {
        guard let city = CityModelController.shared.exploreCity else { return }
        self.cityModelData = SelectedCityModel(
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
    
    func assignCity(newCity: SelectedCityModel) {
        if let existingCity = CityModelController.shared.cities.first(where: { $0.latitude == newCity.latitude && $0.longitude == newCity.longitude }) {
            cityData = existingCity
        } else {
            networkManager.fetchFlagImageData(with: newCity.countryCode) { [weak self] data in
                self?.cityData = City(context: CoreDataStack.context)
                self?.cityData?.name = newCity.cityName
                self?.cityData?.countryCode = newCity.countryCode
                self?.cityData?.latitude = newCity.latitude
                self?.cityData?.longitude = newCity.longitude
                self?.cityData?.isFavorited = false
                self?.cityData?.willVisit = false
                self?.cityData?.didVisit = false
                self?.cityData?.image = data
                CityModelController.shared.saveData()
            }
        }
    }
}
