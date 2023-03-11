//
//  ViewController.swift
//  meteo_app
//
//  Created by mohammed ichou on 06/03/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var initTable = false
    let searchController = UISearchController()
    var tablallcities : [String] = []
    var tablefilter : [String] = []
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        initpage()
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
          print("afficher")
          print(LocationService.shared.getcurrentlocation())
       }
    
    func inittable(){
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
    }
    
    func initpage(){
        LocationService.shared.initlocation()
        initcountry()
        title = "Mes villes"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func initcountry(){
        print("START INIT TAB COUNTRY")
        Apiservice.shared.decodeAPIcity { tab in
            let tab : Country = tab
            print(tab.data.first?.cities)
            self.generatetab(tab: tab)
        } onFailure: { err in
            print(err)
        }

    }
    
    func generatetab(tab : Country){
        for i in 0...tab.data.count-1{
            print(i)
            print(tab.data[i].cities)
            tablallcities.append(contentsOf: tab.data[i].cities)
        }
        tablefilter = tablallcities
        print(tablefilter)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("test")
          tableView.removeFromSuperview()
            
            
            /* Cannot access tableview constraints from here because extension is outside of the class */
        }
        
    
    
    
    


}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
          guard let text = searchController.searchBar.text else{
              return
          }
        let filtered = tablallcities.filter { $0.contains(text) }
        print(filtered)
        tablefilter = filtered
        tableView.reloadData()
        print(text)
         
      }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        inittable()
        print("begin")
    }
    

    
  
}

extension ViewController {
    func subviews() {
        view.addSubview(tableView)
    }

    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tablefilter.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        print(tablefilter.first)
        cell.textLabel?.text = tablefilter[indexPath.row]
        return cell
    }


}

