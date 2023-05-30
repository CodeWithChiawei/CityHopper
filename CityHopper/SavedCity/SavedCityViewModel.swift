//
//  SegmentViewModel.swift
//  CityHopper
//
//  Created by chiawei wen on 4/7/23.
//

import Foundation

class SavedCityViewModel {
    
    var cityData = [City]()
    
    func filterData(with cities: [City], by selectedIndex: Int) {
        switch selectedIndex {
        case 0:
            self.cityData = cities.filter { $0.willVisit == true }
        case 1:
            self.cityData = cities.filter { $0.didVisit == true }
        case 2:
            self.cityData = cities.filter { $0.isFavorited == true }
        default:
            break
        }
    }
}
