//
//  Apiservice.swift
//  meteo_app
//
//  Created by mohammed ichou on 08/03/2023.
//

import Foundation

class Apiservice{
    
    static let shared = Apiservice()
    
    
    
    func callAPI(){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lang=fr&lat=48.866667&lon=2.333333&units=metric&appid=a4ae7d12d35c1495e11c5300200470cd") else{
            return
        }


        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
            }
        }

        task.resume()
    }
    
    
    
    
    func decodeAPI(_ onSuccess: @escaping(City) -> Void, onFailure: @escaping(Error) -> Void){
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lang=fr&lat=48.866667&lon=2.333333&units=metric&appid=a4ae7d12d35c1495e11c5300200470cd") else{return}

        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            let decoder = JSONDecoder()

            if let data = data{
                do{
                    let city : City = try decoder.decode(City.self, from: data)
                    onSuccess(city)
                }catch{
                    print(error)
                    onFailure(error)
                }
            }
        }
        task.resume()

    }
    
}
