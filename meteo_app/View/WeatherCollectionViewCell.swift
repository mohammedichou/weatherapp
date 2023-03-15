//
//  WeatherCollectionViewCell.swift
//  meteo_app
//
//  Created by mohammed ichou on 11/03/2023.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var viewMain: UIView!
    
    @IBOutlet weak var Minlabel: UILabel!
    @IBOutlet weak var Maxlabel: UILabel!
    @IBOutlet weak var descriplabel: UILabel!
    @IBOutlet weak var hourslabel: UILabel!
    @IBOutlet weak var Templabel: UILabel!
    @IBOutlet weak var Mainlabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMain.backgroundColor = .gray
        viewMain.layer.cornerRadius = viewMain.frame.width / 20
        
        
        // Initialization code
    }

    func update(text : String){
        Mainlabel.text = text
    }
}
