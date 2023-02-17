//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Rania Arbash on 2023-02-03.
//

import UIKit

class WeatherViewController: UIViewController  {

    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var main: UILabel!
    
    
 //https://api.openweathermap.org/data/2.5/weather?q=Toronto,Canada&appid=d0eaa0c4f0663a05b88a948b96fee30c
   
    var key = "d0eaa0c4f0663a05b88a948b96fee30c"
    var url1 = "https://api.openweathermap.org/data/2.5/weather?q="
    var url2 = "&appid="
    
    
    
    
    var selectedCity : City?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedCity?.cityName
        
        var fullURL = url1 + selectedCity!.cityName +
        "," + selectedCity!.countryName  + url2 + key
        
//        var fullURL = "https://api.openweathermap.org/data/2.5/weather?q=Toronto,Canada&appid=d0eaa0c4f0663a05b88a948b96fee30c"
       
        
        var imageURL = "http://openweathermap.org/img/wn/"
        var imageURL2 = "@2x.png"
        
        NetworkingService.shared.getData2(fullurl: fullURL) { result in
            switch result {
            case .failure(let error):
                print(error)
                break
            case .success(let data):
               var wo = JsonService.shared.parseWeatherJson(data: data)
                NetworkingService.shared.getData2(fullurl: imageURL+wo.weather[0].icon+imageURL2) { result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            self.icon.image = UIImage(data: imageData)
                        }
                        break
                    case .failure(let error):
                        break
                    }
                }
                
                DispatchQueue.main.async {
                    self.temp.text = "\(wo.main.temp - 273 )"
                    self.main.text = wo.weather[0].main
                    
                }
                
                break
            }
            
        
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
