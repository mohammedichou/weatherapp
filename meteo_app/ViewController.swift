//
//  ViewController.swift
//  meteo_app
//
//  Created by mohammed ichou on 06/03/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let searchController = UISearchController()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initpage()
        /*Apiservice.shared.decodeAPI { city in
            print(city)
            let city : City = city
            print(city.name)
        } onFailure: { str in
            print(str)
        }*/


        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
          print("afficher")
          print(LocationService.shared.getcurrentlocation())
       }
    
    func initpage(){
        LocationService.shared.initlocation()
        title = "Mes villes"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
    }
        
    
    
    
    


}

extension ViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
      guard let text = searchController.searchBar.text else{
          return
      }
      print(text)
  }
}


