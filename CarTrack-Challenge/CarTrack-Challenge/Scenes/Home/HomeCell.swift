//
//  HomeCell.swift
//  CarTrack-Challenge
//
//  Created by Aaron Ang on 6/5/21.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameTitleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailTitleLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyTitleLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setText()
        self.infoView.layer.cornerRadius = 8.0
        self.infoView.layer.borderColor = UIColor.lightGray.cgColor
        self.infoView.layer.borderWidth = 0.25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setText() {
        self.nameTitleLabel.text = localizedString("__t_home_cell_name")
        self.usernameTitleLabel.text = localizedString("__t_home_cell_username")
        self.phoneTitleLabel.text = localizedString("__t_home_cell_phone")
        self.emailTitleLabel.text = localizedString("__t_home_cell_email")
        self.companyTitleLabel.text = localizedString("__t_home_cell_company")
    }

    func updateDisplay(user: User) {
        self.nameLabel.text = user.name
        self.usernameLabel.text = user.username
        self.phoneLabel.text = user.phone
        self.emailLabel.text = user.email
        self.companyLabel.text = user.company?.name
    }
}
