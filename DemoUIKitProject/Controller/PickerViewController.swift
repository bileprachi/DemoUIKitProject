//
//  PickerViewController.swift
//  Here in this Controller we are creating Picker view for DOB Field - day, month and year
//
//  Created by Prachi Bile on 25/01/21.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {

    @IBOutlet var countryTextField: UITextField!
    @IBOutlet var stateTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var dayTextField: UITextField!
    @IBOutlet var monthTextField: UITextField!
    @IBOutlet var yearTextField: UITextField!
    
    // Picker View for DOB - Day/Month/Year
    let dayPickerView = UIPickerView()
    let monthPickerView = UIPickerView()
    let yearPickerView = UIPickerView()
    
    var birthDate = PickerData()  // Object of PickerData swift class
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPickerView()
        tagForPicker()
//        dismissPickerView()
    
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(PickerViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(PickerViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
       }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }

    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    func createPickerView() {
        selfPickerViewDelegate()
        dayTextField.inputView = dayPickerView
        monthTextField.inputView = monthPickerView
        yearTextField.inputView = yearPickerView
    }
    
    func selfPickerViewDelegate() {
        dayPickerView.delegate = self
        monthPickerView.delegate = self
        yearPickerView.delegate = self
    }
    
    //tag
    func tagForPicker() {
        dayPickerView.tag = 1
        monthPickerView.tag = 2
        yearPickerView.tag = 3
    }
    
//    func dismissPickerView() {
//        dayPickerView.isHidden = true
//        monthPickerView.isHidden = true
//        yearPickerView.isHidden = true
//    }
    
//    func dismissPickerView() {
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        let btn = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(action))
//        toolBar.setItems([btn], animated: true)
//        toolBar.isUserInteractionEnabled = true
//        dayTextField.inputAccessoryView = toolBar
//    }
    
//    @objc func action() {
//          view.endEditing(true)
//    }
    
    // MARK: UIPickerViewDelegate, UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return birthDate.day.count
        case 2:
            return birthDate.month.count
        case 3:
            return birthDate.year.count
        default:
            return 1
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return birthDate.day[row]
        case 2:
            return birthDate.month[row]
        case 3:
            return String(birthDate.year[row])
        default:
            return "Something Went Wrong"
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            dayTextField.text = birthDate.day[row]
            self.view.endEditing(true)  // Dismiss DayPicker View After Selection
        }
        else if pickerView.tag == 2 {
            monthTextField.text = birthDate.month[row]
            self.view.endEditing(true)  // Dismiss MonthPicker View
        }
        else if pickerView.tag == 3 {
            yearTextField.text = String(birthDate.year[row])
            self.view.endEditing(true)  // Dismiss YearPicker View
        }
    }
    
    // MARK: UITextFieldDelegate
    //function to hide keyborad on click on return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        // Alert
        let alertController = UIAlertController(title: "Hello", message: "Thank You!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
                UIAlertAction in
                NSLog("Cancel Pressed")
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
