//
//  WeatherManager.swift
//  Clima
//
//  Created by Luiz Silva on 12/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager{
    
    let baseUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=5ed0b724b45c36462d3e2e53808ff80b&units=metric"
    
    func FetchWeather(cityName: String){
        
        let urlString = "\(baseUrl)&q=\(cityName)"
        print (urlString)
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String){
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    //let dataString = String(data: safeData, encoding: .utf8)
                    self.parseJSON(wheatherData: safeData)
                    
                }
            }
            
            task.resume()
        
    }
    
   
    }
    
    func parseJSON(wheatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: wheatherData)
            print(decodedData.main.temp)
        }
        catch {
                print(error)
            }
    }
    
}
