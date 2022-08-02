//
//  CustomTableViewCell.swift
//  News
//
//  Created by Saurav Sharma on 01/08/22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        self.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.borderWidth = 0.25
        self.layer.cornerRadius = 5
        authorLabel.layer.masksToBounds = true
       // authorLabel.textco = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 5)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.kf.cancelDownloadTask()
        newsImageView.kf.setImage(with: URL(string: ""))
        newsImageView.image = nil
    }
}
