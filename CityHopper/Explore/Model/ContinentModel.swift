//
//  ContinentModel.swift
//  CityHopper
//
//  Created by chiawei wen on 3/15/23.
//

import Foundation
import UIKit

struct ContinentModel {
    let continent: String
    let color: UIColor
    let image: UIImage?
    let latitude: Double
    let longitude: Double
    var isSelected: Bool
}

class ContinentData {
    
    var continentModelData: [ContinentModel] = [
        ContinentModel(continent: "Asia", color: .systemPink.withAlphaComponent(0.85), image: UIImage(named: "asia"), latitude: 39, longitude: 101, isSelected: false),
        ContinentModel(continent: "North America", color: .systemBlue.withAlphaComponent(0.85), image: UIImage(named: "northAmerica"), latitude: 46, longitude: -94, isSelected: false),
        ContinentModel(continent: "South America", color: .systemCyan.withAlphaComponent(0.85), image: UIImage(named: "southAmerica"), latitude: -12, longitude: -75, isSelected: false),
        ContinentModel(continent: "Oceania", color: .systemRed.withAlphaComponent(0.85), image: UIImage(named: "oceania"), latitude: -28, longitude: 148, isSelected: false),
        ContinentModel(continent: "Europe", color: .systemOrange.withAlphaComponent(0.85), image: UIImage(named: "europe"), latitude: 51, longitude: 31, isSelected: false),
        ContinentModel(continent: "Antarctica", color: .systemIndigo.withAlphaComponent(0.85), image: UIImage(named: "antarctica"), latitude: -80, longitude: 26, isSelected: false),
        ContinentModel(continent: "Africa", color: .systemGreen.withAlphaComponent(0.85), image: UIImage(named: "africa"), latitude: 6, longitude: 21, isSelected: false	)
    ]
}
