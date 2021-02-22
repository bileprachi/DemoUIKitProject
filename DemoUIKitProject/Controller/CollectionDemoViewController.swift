//
//  CollectionDemoViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 02/02/21.
//

import UIKit

class CollectionDemoViewController: UIViewController {

    @IBOutlet weak var natureCollectionView: UICollectionView!
    
    var collectionItems = CollectionItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewSetting()
    }
    
    func collectionViewSetting() {
        self.natureCollectionView.delegate = self
        self.natureCollectionView.dataSource = self
    }
    
    func collectionViewItemSetting() {
    }
}

extension CollectionDemoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionItems.imageTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let natureCell = natureCollectionView.dequeueReusableCell(withReuseIdentifier: StoryboardIdentifier.collectionCellIdentifier, for: indexPath) as! NatureCollectionViewCell
        natureCell.natureImage.image = collectionItems.imageItem[indexPath.row]
        natureCell.natureNameLabel.text = collectionItems.imageTitle[indexPath.row]
        return natureCell
    }
    
    // Push DetailedCollection view controller on click on nature image
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = storyboard?.instantiateViewController(identifier: StoryboardIdentifier.DetailedCollectionViewVCIdentifier) as? DetailedCollectionViewController
        print("Row on Collection View: \(indexPath.row)")
        print("Item at Row: \(collectionItems.imageTitle[indexPath.row])")
        detailedVC?.imageTitle = collectionItems.imageTitle[indexPath.row] //Set Detailed VC's property
        
        // Warning/ERROR: We can not use IBOutlet directly here, because that detailed VC is not yet loaded and so IBOutlets are not yet available, so it will give error of "Unexpectedly found nil while implicitly unwrapping an Optional value"
        //detailedVC?.imageTitleLabel.text = collectionItems.imageTitle[indexPath.row]
        
        self.navigationController?.pushViewController(detailedVC!, animated: true)
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    // Give Proper size of collection view cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let natureCollectionViewWidth = natureCollectionView.bounds.width
        return CGSize(width: natureCollectionViewWidth/2 - 1, height: natureCollectionViewWidth/2 - 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
}
