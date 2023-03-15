//
//  DataService.swift
//  meteo_app
//
//  Created by mohammed ichou on 12/03/2023.
//

import Foundation

class DataService {
    
    static let shared = DataService()
    
    
    func readDatafrom(ville : String) {
            let userDefaults = UserDefaults.standard
            let object = userDefaults.object(forKey: ville)
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode(City.self, from: object as! Data) {
                    print(decoded)
                }
        }
    
    func writedata(city : City, ville : String, _ onSuccess: ()){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(city) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: ville)
        }
        onSuccess
    }
    
    func addville(ville : String, _ onSuccess: ()){
        var array : [String] = []
        let userDefaults = UserDefaults.standard
        let object = userDefaults.object(forKey: "villes")
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String].self, from: object as! Data) {
            array = decoded
            array.append(ville)
            }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "villes")
            onSuccess
        }
    }
    
    func getallville(_ onSuccess: @escaping([String]) -> Void){
        let userDefaults = UserDefaults.standard
        let object = userDefaults.object(forKey: "villes")
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String].self, from: object as! Data) {
                onSuccess(decoded as! [String])
            }
    }
    
    func removeville(ville : String){
        var array : [String] = []
        let userDefaults = UserDefaults.standard
        let object = userDefaults.object(forKey: "villes")
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([String].self, from: object as! Data) {
            array = decoded
            array = array.filter(){$0 != ville}
            }
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(array) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "villes")
        }
    }
    
    func getonemeteo(ville : String, _ onSuccess: @escaping(City) -> Void){
        print("getone \(ville)")
        let userDefaults = UserDefaults.standard
        let object = userDefaults.object(forKey: ville)
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode(City.self, from: object as! Data) {
                onSuccess(decoded as! City)
            }
    }
    
    
    
}


