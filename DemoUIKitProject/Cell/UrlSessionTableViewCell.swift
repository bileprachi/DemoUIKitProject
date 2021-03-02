//
//  UrlSessionTableViewCell.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 25/02/21.
//

import UIKit

class UrlSessionTableViewCell: UITableViewCell {

    @IBOutlet var dataImageView: UIImageView!
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var IDLbl: UILabel!
    @IBOutlet var artistNameLbl: UILabel!
    @IBOutlet var artistIDLbl: UILabel!
    @IBOutlet var releaseDateLbl: UILabel!
    @IBOutlet var copyrightLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
