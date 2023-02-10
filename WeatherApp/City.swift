//
//  City.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-03.
//

import Foundation

class City {
    var cityName: String = ""
    var stateName: String = ""
    var countryName : String = ""
    
    
    init(city : String, state: String, country : String){
        self.cityName = city
        self.countryName = country
        self.stateName = state
       
    }
    
    
}
