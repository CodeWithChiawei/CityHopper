//
//  CityCoreData.swift
//  CityHopper
//
//  Created by chiawei wen on 3/29/23.
//

import Foundation
import UIKit
import CoreData

class CityCoreData: NSManagedObject {
    
    class func fetchCity() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }
    
    
    @NSManaged var name: String?
    @NSManaged var countryCode: String?
    @NSManaged var countryName: String?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var isFavortied: Bool
    @NSManaged var didVisit: Bool
    @NSManaged var willVisit: Bool
    @NSManaged var image: Data
}
