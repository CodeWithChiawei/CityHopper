//
//  SearchScreenViewModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/29/23.
//

import Foundation
import UIKit
import CoreLocation

class ExploreViewModel {
    
    private let networkManager = NetworkManager()
    
    func fetchCity(completion: @escaping (Result<FetchCityModel, Error>) -> Void) {
        guard let continent = UserDefaults.standard.string(forKey: UserDefaultKeys.selectedCellContinent.rawValue) else { return }
        networkManager.fetchCountryJSON(with: continent) { result in
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
}
