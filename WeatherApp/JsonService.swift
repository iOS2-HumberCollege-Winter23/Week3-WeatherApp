//
//  JsonService.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-01-27.
//

import Foundation


class JsonService {
    static var shared = JsonService()
    
    func parseJson (data : Data) -> [String]{
        
        let xData = String(data: data, encoding: .utf8)?.data(using: .utf8)
        let listOfCities = try? JSONDecoder().decode([String].self,from: xData!)
                            // "Toronto , ON, Canada"
        
        var result =   listOfCities?.reduce(into: [String]()){
                            let separatesNames = $1.split(separator: ",") // ["Toronto", "ON" , "Canada"]
                          if (separatesNames.count == 3 ){
                            $0.append(separatesNames[0] + "" + separatesNames[2])
                          }
                        }
        
        return result!
    }
    
}
