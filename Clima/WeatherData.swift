//
//  WeatherData.swift
//  Clima
//
//  Created by Luiz Silva on 12/11/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable{
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
}
