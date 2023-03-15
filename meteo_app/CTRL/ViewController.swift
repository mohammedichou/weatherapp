//
//  ViewController.swift
//  meteo_app
//
//  Created by mohammed ichou on 06/03/2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UISearchControllerDelegate, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    let searchController = UISearchController()
    var tablallcities : [String] = []
    var tablefilter : [String] = []
    var tableallVille : [String] = []
    var allmeteo : [City] = []
    var currentmeteo : City?
    
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var collectionView: UICollectionView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ConnectedService.shared.getstatus())
        initpage()
        DataService.shared.getallville { allville in
            self.tableallVille = allville
            self.inittableaumeteo()
        }
        
        
        
    }
    
    func initpage(){
        LocationService.shared.initlocation()
        initcountry()
        initcollection()
        initsearchBar()
    }
    
    
    func initcollection(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
                return
        }
                
        let nib = UINib(nibName: "WeatherCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "Collection")
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.frame = view.bounds
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 120)
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        flowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        flowLayout.minimumInteritemSpacing = 0.0
        
        collectionView.collectionViewLayout = flowLayout
        setupLongGestureRecognizerOnCollection()
        view.addSubview(collectionView)
    }

    override func viewDidAppear(_ animated: Bool) {
        
       }
    
    
    func inittable(){
        tableView.delegate = self
        tableView.dataSource = self
        subviews()
        constraints()
        
    }
    
    

    
    
    func initsearchBar(){
        title = "Mes villes"
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    func initcountry(){
        print("START INIT TAB COUNTRY")
        Apiservice.shared.decodeAPIcity { tab in
            let tab : Country = tab
            self.generatetab(tab: tab)
        } onFailure: { err in
            print(err)
        }

    }
    
    func inittableaumeteo(){
        for i in 0...tableallVille.count-1{
            print(tableallVille[i])
            DataService.shared.getonemeteo(ville: tableallVille[i]) { meteo in
                self.allmeteo.append(meteo)
                if(i == self.tableallVille.count - 1){
                    self.collectionView?.reloadData()
                }
            }
        }
    }
    
    func generatetab(tab : Country){
        for i in 0...tab.data.count-1{
           // print(i)
           // print(tab.data[i].cities)
            tablallcities.append(contentsOf: tab.data[i].cities)
        }
        tablefilter = tablallcities
        //print(tablefilter)
    }

    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            print("test")
          tableView.removeFromSuperview()
        }
    
    private func setupLongGestureRecognizerOnCollection() {
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        collectionView?.addGestureRecognizer(longPressedGesture)
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if (gestureRecognizer.state != .began) {
            return
        }

        let p = gestureRecognizer.location(in: collectionView)

        if let indexPath = collectionView?.indexPathForItem(at: p) {
            print("Long press at item: \(indexPath.row)")
            DataService.shared.removeville(ville: tableallVille[indexPath.row])
            tableallVille.remove(at: indexPath.row)
            allmeteo.remove(at: indexPath.row)
            collectionView?.reloadData()
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableallVille.count
        }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection", for: indexPath) as! WeatherCollectionViewCell
        let city : City = allmeteo[indexPath.row]
        cell.Templabel.text = "\(Int(city.main.temp)) °"
        cell.Maxlabel.text = "\(Int(city.main.temp_max)) °"
        cell.Minlabel.text = "\(Int(city.main.temp_min)) °"
        cell.descriplabel.text = city.weather[0].description
        cell.update(text: tableallVille[indexPath.row])
        
        
            return cell
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        GeocodingService.shared.forwardGeocoding(address: tableallVille[indexPath.row]) { coord in
            Apiservice.shared.decodeAPI(lat: coord.latitude, long: coord.longitude) { city in
                self.currentmeteo = city
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Gotometeo", sender: nil)
                }
            } onFailure: { err in
                print(err)
            }

            
            
        } onFailure: { err in
            print(err)
        }

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
        //print(text)
         
      }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar){
        inittable()
        print("begin")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "Gotometeo"){
            if let second = segue.destination as? MeteoCtrl{
                second.city = currentmeteo
            }
        }
        
    }
    

    
  
}

extension ViewController {
    func subviews() {
        view.addSubview(tableView)
    }
    
    func subviewscollection(){
       // view.addSubview(collectionview)
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
            cell.textLabel?.text = tablefilter[indexPath.row]
        
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        print(indexPath.row)
        GeocodingService.shared.forwardGeocoding(address: tablefilter[indexPath.row]) { coord in
            Apiservice.shared.decodeAPI(lat: coord.latitude, long: coord.longitude) { city in
                DataService.shared.writedata(city: city, ville: self.tablefilter[indexPath.row], (
                    DataService.shared.addville(ville: self.tablefilter[indexPath.row], (
                        
                       
                        DispatchQueue.main.async {
                            self.tableallVille.append(self.tablefilter[indexPath.row])
                            self.allmeteo.append(city)
                            self.inittableaumeteo()
                            self.tableView.removeFromSuperview()
                            
                           
                        }
                    ))
                ))
                
                
                
                
            } onFailure: { err in
                print(err)
            }
        } onFailure: { err in
            print(err)
        }

        

        
    }
    


}


