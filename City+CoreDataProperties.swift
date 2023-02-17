//
//  City+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-10.
//
//

import Foundation
import CoreData


extension City {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<City> {
        return NSFetchRequest<City>(entityName: "City")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var provice: String?
    @NSManaged public var country: String?

}

extension City : Identifiable {

}
