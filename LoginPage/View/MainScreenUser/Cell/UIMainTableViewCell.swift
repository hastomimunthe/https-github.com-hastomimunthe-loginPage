//
//  UIMainTableViewCell.swift
//  LoginPage
//
//  Created by Hastomi Riduan Munthe on 23/02/23.
//

import UIKit
import Kingfisher


class UIMainTableViewCell: UITableViewCell {
    
    @IBOutlet weak var idText: UILabel!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var imagePhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        imagePhoto.contentMode = .scaleAspectFill
        imagePhoto.layer.cornerRadius = 8
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure (photo: Photo) {
        idText.text = "\(photo.id)"
        titleText.text = photo.title
        guard let url = URL(string: photo.url) else { return }
        imagePhoto.kf.setImage(with: url)
        
    }
    
}
