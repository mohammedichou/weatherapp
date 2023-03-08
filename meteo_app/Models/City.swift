//
//  City.swift
//  meteo_app
//
//  Created by mohammed ichou on 08/03/2023.
//

import Foundation


struct City: Identifiable, Codable {
    var coord: Coord
    var weather: [Weather]
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    
    struct Weather: Codable {
        var id: Int
        var main: String
        var description: String
        var icon: String
    }
    
    struct Coord: Codable {
        var lon: Double
        var lat: Double
    }

    struct Main: Codable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Int
        var humidity: Int
    }

    struct Wind: Codable {
        var speed: Double
        var deg: Int
    }

    struct Clouds: Codable {
        var all: Int
    }
    
    struct Sys: Codable {
        var type: Int
        var id: Int
        var country: String
        var sunrise: Int
        var sunset: Int
    }
}
