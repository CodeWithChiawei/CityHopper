//
//  CityFetchModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//


struct CityFetchModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case city = "response"
    }
    let city: [FetchCityModel]
}

struct FetchCityModel: Codable {
    private enum CodingKeys: String, CodingKey {
        case name
        case latitude = "lat"
        case longitude = "lng"
        case countryCode = "country_code"
    }
    
    let name: String
    let latitude: Double
    let longitude: Double
    let countryCode: String
}
