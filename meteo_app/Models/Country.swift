//
//  country.swift
//  meteo_app
//
//  Created by mohammed ichou on 09/03/2023.
//

import Foundation

struct Country: Codable {
    var data : [City2]
}

struct City2: Codable{
    var country : String
    var cities : [String]
}
