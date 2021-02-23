//
//  TextFieldViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 25/01/21.
//

import UIKit

class TextFieldViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var name: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var phone: UITextField!
    @IBOutlet var requirement: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Text Field Delegates
        name.delegate = self
        email.delegate = self
        phone.delegate = self
        requirement.delegate = self
        
        // Keyboard show and hide apearance
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    var isExapand: Bool = false
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isExapand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 300)
            isExapand = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if isExapand {
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - 300)
            isExapand = false
        }
    }
    
    @IBAction func submitPressed(sender: Any) {
        
        self.view.endEditing(true)
        
        let getName: String = name.text ?? ""
        let getEmail: String = email.text ?? ""
        let getPhone: String = phone.text ?? ""
        let getRequirement: String = requirement.text ?? ""
        
        if (getName == "" || getEmail == "" || getPhone == "" || getRequirement == "") {
            // Create alert Controller if "Not Giving all Values"
            let alertController = UIAlertController(title: "Hello Dear!", message: "Please Enter All fields", preferredStyle: .alert)
            
            // Create Actions
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            // Create alert Controller if "Giving all Values"
            let alertController = UIAlertController(title: "Thank You!", message: "We will get back to you soon.", preferredStyle: .alert)
            
            // Create Actions
            let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                    UIAlertAction in
                    NSLog("Cancel Pressed")
                }
            
            // Add the actions
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            
            name.text = ""
            email.text = ""
            phone.text = ""
            requirement.text = ""
            
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Returning")
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("Begin Editing")
        textField.clearButtonMode = .whileEditing
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Clearing")
        return true
    }
    
    // phone TextField only accepts numbers
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == phone {
            let allowedCharacters = "+1234567890"
            let allowedCharSet = CharacterSet(charactersIn: allowedCharacters)
            let typedCharSet = CharacterSet(charactersIn: string)
            return allowedCharSet.isSuperset(of: typedCharSet)
        }
        return true
    }

}
