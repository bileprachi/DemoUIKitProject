//
//  ImageViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 27/01/21.
//

import UIKit

class ImageViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var reviewSegmentControl: UISegmentedControl!
    @IBOutlet weak var reviewTextArea: UITextView!
    @IBOutlet weak var suggestionTextArea: UITextView!
    @IBOutlet weak var cartCountLabel: UILabel!
    @IBOutlet weak var addToCartStepper: UIStepper!
    
    var bookDetails = Book()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add keyboard hide and appeare facility
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Text Views border
        reviewTextArea.layer.borderWidth = 0.2
        suggestionTextArea.layer.borderWidth = 0.2
        
        // Adding Placeholder to Text Views
        reviewTextArea.text = "Leave your review here ..."
        reviewTextArea.textColor = UIColor.lightGray
        suggestionTextArea.text = "Leave your suggestion here ..."
        suggestionTextArea.textColor = UIColor.lightGray
        
        // Text View Delegate
        self.reviewTextArea.delegate = self
        self.suggestionTextArea.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == reviewTextArea {
            if  reviewTextArea.textColor == UIColor.lightGray {
                reviewTextArea.text = nil
                reviewTextArea.textColor = UIColor.black
            }
        }
        if textView == suggestionTextArea {
            if suggestionTextArea.textColor == UIColor.lightGray {
                suggestionTextArea.text = nil
                suggestionTextArea.textColor = UIColor.black
            }
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if reviewTextArea.text.isEmpty {
            reviewTextArea.text = "Leave your review here ..."
            reviewTextArea.textColor = UIColor.lightGray
        }
        if suggestionTextArea.text.isEmpty {
            suggestionTextArea.text = "Leave your suggestion here ..."
            suggestionTextArea.textColor = UIColor.lightGray
        }
    }
 
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            reviewTextArea.resignFirstResponder()
            suggestionTextArea.resignFirstResponder()
        }
        return true
    }
    
    @IBAction func doneBtnTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Thank You!", message: "Your Valuable Review and Suggestion has been saved", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func reviewSegmentChanged(_ sender: Any) {
        switch reviewSegmentControl.selectedSegmentIndex {
        case 0:
            print("Selected: Recommending")
            bookDetails.recommendation = "Recommending"
        case 1:
            print("Selected: Not Recommending")
            bookDetails.recommendation = "Not Recommending"
        default:
            print("Selected: Recommending")
            bookDetails.recommendation = ""
            break
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: Any) {
        cartCountLabel.text = Int(addToCartStepper.value).description
        bookDetails.cartCount = Int(addToCartStepper.value)
    }
    
    var isExapand: Bool = false
    @objc func keyboardShow() {
        print("Inside keyboardShow")
        if !isExapand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 300)
            isExapand = true
        }
    }
    
    @objc func keyboardHide() {
        print("Inside keyboardShow")
        if isExapand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 300)
            isExapand = false
        }
    }

}
