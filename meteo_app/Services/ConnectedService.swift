//
//  ConnectedService.swift
//  meteo_app
//
//  Created by mohammed ichou on 14/03/2023.
//

import Foundation
import Network

class ConnectedService {
    
    static let shared = ConnectedService()
    let monitor = NWPathMonitor()
    var status : Bool = true
    
    
    
    
    
    func initqueue(){
        monitor.pathUpdateHandler = { pathUpdateHandler in
            print("ICI")
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                self.status = true
            } else {
                print("There's no internet connection.")
                self.status = false
            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
    
    
    func getstatus()->Bool{
        return status
    }
    
    
}
