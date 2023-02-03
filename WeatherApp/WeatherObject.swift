//
//  WeatherObject.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-03.
//

import Foundation


class WeatherObject : Codable {
    var weather : [weather]
    var main : main
    var visibility : Int
}

class weather : Codable {
    var main : String
    var icon  : String
}

class main : Codable {
    var temp : Float
    var feels_like : Float
}
