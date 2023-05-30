//
//  CountryFetchModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//

import Foundation

struct CountryFetchModel: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case NorthAmerica = "North America"
        case SouthAmerica = "South America"
        case Africa
        case Antarctica
        case Asia
        case Europe
        case Oceania
    }
    
    let Africa: [Country]
    let Antarctica: [Country]
    let Asia: [Country]
    let Europe: [Country]
    let NorthAmerica: [Country]
    let SouthAmerica: [Country]
    let Oceania: [Country]

}

struct Country: Codable {
    let country_code: String
    let name: String
}
