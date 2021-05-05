//
//  CountryCell.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 5/5/21.
//

import UIKit

class CountryCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateDisplay(country: String, selectedCountry: String) {
        self.countryLabel.text = country
        if country == selectedCountry {
            self.accessoryType = .checkmark
        } else {
            self.accessoryType = .none
        }
    }
}
