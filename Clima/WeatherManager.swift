//
//  WeatherManager.swift
//  Clima
//
//  Created by Luiz Silva on 12/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager{
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=5ed0b724b45c36462d3e2e53808ff80b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func FetchWeather(cityName: String){
        
        let urlString = "\(baseUrl)&q=\(cityName)"
        print (urlString)
        performRequest(urlString: urlString)        
    }
    
    func FetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        
        let urlString = "\(baseUrl)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(wheatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                    
                    
                }
            }
            
            task.resume()
        
    }
    
   
    }
    
    func parseJSON(wheatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: wheatherData)
            print(decodedData.main.temp)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        }
        catch {
            delegate?.didFailWithError(error: error)
            print(error)
            return nil
            }
    }
    

    
}
