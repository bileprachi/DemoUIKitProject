//
//  DetailedCollectionViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 02/02/21.
//

import UIKit

class DetailedCollectionViewController: UIViewController {

    @IBOutlet weak var imageTitleLabel: UILabel!
    @IBOutlet weak var natureImage: UIImageView!
    
    // Property to get Title of image from previeous screen
    var imageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Image Title on Detailed VC: \(imageTitle)")
        // Set Values in Outlets
        imageTitleLabel.text = imageTitle
        natureImage.image = UIImage(named: imageTitle)
    }
}
