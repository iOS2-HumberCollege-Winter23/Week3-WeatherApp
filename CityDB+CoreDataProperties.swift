//
//  CityDB+CoreDataProperties.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-10.
//
//

import Foundation
import CoreData


extension CityDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityDB> {
        return NSFetchRequest<CityDB>(entityName: "CityDB")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var provice: String?
    @NSManaged public var country: String?

}

extension CityDB : Identifiable {

}
