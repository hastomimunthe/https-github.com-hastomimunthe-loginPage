//
//  AdminTableViewCell.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit

class AdminTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var emailText: UILabel!
    @IBOutlet weak var idText: UILabel!
    @IBOutlet weak var roleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    func configure (user: User) {
        userName.text = user.username
        emailText.text = user.email
        roleText.text = user.role
        idText.text = user.id?.uuidString
    }
    
    
}
