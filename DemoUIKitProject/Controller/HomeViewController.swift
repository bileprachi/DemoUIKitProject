//
//  HomeViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 25/01/21.
//  Description: This controller is a Home Screen Table View Controller, from which we can move to any other controller on click of any one item of table View

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeScreenTableView: UITableView!
    
    var tableCellData = TableData()     // Object of TableData class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        
        //make table View look good
        homeScreenTableView.showsVerticalScrollIndicator = false
    }
    
    // Assign DataSource and Delegate to self
    func setTableViewDelegate() {
        homeScreenTableView.dataSource = self
        homeScreenTableView.delegate = self
    }
}

//MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1            // Section = 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableCellData.titleTableData.count   // This is coming from class TableData
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100          // Each Row height = 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myTableViewCell = homeScreenTableView.dequeueReusableCell(withIdentifier: StoryboardIdentifier.cellIdentifier, for: indexPath) as! HomeTableViewCell
        print("Row: \(indexPath.row) ")
        myTableViewCell.imageTableView.image = self.tableCellData.imageTableData[indexPath.row]
        myTableViewCell.titleLblTableView.text = self.tableCellData.titleTableData[indexPath.row]
        myTableViewCell.descriptionLblTableView.text = self.tableCellData.descriptionTableData[indexPath.row]
        
        //make cell look good
        myTableViewCell.layer.cornerRadius = myTableViewCell.layer.frame.height / 2
        
        return myTableViewCell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Click on any one to go ahead - "
//    }
    
//    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
//        return "By Prachi Bile"
//    }
    
}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        // Call TextField View Controller
        if self.tableCellData.titleTableData[indexPath.row] == "UITextField" {
            let textFieldVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.textFieldVCIdentifier) as! TextFieldViewController
            self.navigationController?.pushViewController(textFieldVC, animated: true)
        }
        // Call Label View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UILabel" {
            let labelVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.labelVCIdentifier) as! LabelViewController
            self.navigationController?.pushViewController(labelVC, animated: true)
        }
        // Call Picker View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UIPicker" {
            let pickerVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.pickerVCIdentifier) as! PickerViewController
            self.navigationController?.pushViewController(pickerVC, animated: true)
        }
        // Call Button View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UIButton" {
            let buttonVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.buttonVCIdentifier) as! ButtonViewController
            self.navigationController?.pushViewController(buttonVC, animated: true)
        }
        // Call Stack View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UIStackView" {
            let stackVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.stackViewVCIdentifier) as! StackViewController
            self.navigationController?.pushViewController(stackVC, animated: true)
        }
        // Call Image View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UIImageView" {
            let imageViewVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.imageViewVCIdentifier) as! ImageViewController
            self.navigationController?.pushViewController(imageViewVC, animated: true)
        }
        // Call Image View Controller for Text View where Text Views are used
        else if self.tableCellData.titleTableData[indexPath.row] == "UITextView" {
            let textViewVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.imageViewVCIdentifier) as! ImageViewController
            self.navigationController?.pushViewController(textViewVC, animated: true)
        }
        // Call Progress View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UIProgressView" {
            let progressViewVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.progressViewVCIdentifier) as! ProgressViewController
            self.navigationController?.pushViewController(progressViewVC, animated: true)
        }
        // Call Collection View Controller
        else if self.tableCellData.titleTableData[indexPath.row] == "UICollectionView" {
            let collectionViewVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.collectionViewVCIdentifier) as! CollectionDemoViewController
            self.navigationController?.pushViewController(collectionViewVC, animated: true)
        }
        // Call Image View Controller to see stepper used in this
        else if self.tableCellData.titleTableData[indexPath.row] == "UIStepper" {
            let stepperVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.imageViewVCIdentifier) as! ImageViewController
            self.navigationController?.pushViewController(stepperVC, animated: true)
        }
        // Call Image View Controller to see SegmentControl used in this
        else if self.tableCellData.titleTableData[indexPath.row] == "UISegmentControl" {
            let segmentVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.imageViewVCIdentifier) as! ImageViewController
            self.navigationController?.pushViewController(segmentVC, animated: true)
        }
        // Call APICall View Controller to see how to call api and fetch data from
        else if self.tableCellData.titleTableData[indexPath.row] == "APICall" {
            let apiCallVC = storyboard?.instantiateViewController(withIdentifier: StoryboardIdentifier.apiCallURLSessionVCIdentifier) as! APICallURLSessionViewController
            self.navigationController?.pushViewController(apiCallVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print("deselected Item: \(indexPath.item)")
    }
}
