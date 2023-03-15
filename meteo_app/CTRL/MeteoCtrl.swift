//
//  MeteoCtrl.swift
//  meteo_app
//
//  Created by mohammed ichou on 14/03/2023.
//

import UIKit

class MeteoCtrl: UIViewController {
    
    @IBOutlet weak var Img: UIImageView!
    @IBOutlet weak var Villelabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var DescripLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    
    var city : City?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(city?.weather)
        dayLabel.isHidden = true
        Villelabel.text = city?.name ?? ""
        TempLabel.text = "\(Int(city!.main.temp))"
        DescripLabel.text = "\(city?.weather[0].description ?? "")"
        Img.image = UIImage(named: (city?.weather[0].icon) ?? "")

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
