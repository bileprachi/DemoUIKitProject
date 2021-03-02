//
//  HomeTableViewCell.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 26/01/21.
//  Description: This file contains Table View Cell's content's (Image, Title, Description) outlets 

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet var imageTableView: UIImageView!
    @IBOutlet var titleLblTableView: UILabel!
    @IBOutlet var descriptionLblTableView: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
