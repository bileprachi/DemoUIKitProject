//
//  ProgressViewController.swift
//  DemoUIKitProject
//
//  Created by Prachi Bile on 01/02/21.
//  Description - In this View Controller we are using progress bar which will show % image uploading

import UIKit

class ProgressViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, URLSessionDataDelegate, URLSessionTaskDelegate {

    // Progress View Ex1
    @IBOutlet weak var imageToUplaod: UIImageView!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var progressBarImageUplaod: UIProgressView!
    @IBOutlet weak var uploadingPercentageLabel: UILabel!
    
    // Progress View Ex2
    @IBOutlet weak var progressingProgressView: UIProgressView!
    @IBOutlet weak var progressPercentage: UILabel!
    @IBOutlet weak var progressingBtn: UIButton!
    var maxValue = 10.0
    var minValue = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Progress View Ex1
        imageToUplaod.layer.cornerRadius = imageToUplaod.frame.width / 3
        
        // Progress View Ex2
        progressingProgressView.setProgress(Float(minValue), animated: true)
        progressingBtn.layer.cornerRadius = 15
    }

    @IBAction func uploadBtnTapped(_ sender: Any) {
        let uploadImagePickerController = UIImagePickerController()
        uploadImagePickerController.delegate = self
        uploadImagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(uploadImagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          
        imageToUplaod.image = info[.originalImage] as? UIImage
        imageToUplaod.backgroundColor = UIColor.clear
        self.dismiss(animated: true, completion: nil)
        
        uploadYourImage()
    }
            
    func uploadYourImage() {
        let imageData = imageToUplaod.image?.jpegData(compressionQuality: 1)
        if(imageData == nil) {
            return
        }
        
        self.uploadBtn.isEnabled = false
        let uploadImageOnURL = NSURL(string: "https://imgbb.com/")
//        let uploadImageOnURL = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/")
//        let uploadImageOnURL = NSURL(string: "/Users/prachibile/Desktop")
        var request = URLRequest(url: uploadImageOnURL! as URL)
        request.httpMethod = "POST"
        request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        let configuration = URLSessionConfiguration.default
                
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: OperationQueue.main)
        
        //let task = session.uploadTask(with: request, from: imageData!)
        
        let task = session.uploadTask(with: request, fromFile: URL (fileURLWithPath: "/Users/prachibile/Desktop/iOS/images/UIElements/AppIcon/appstore.png"))
        task.resume()
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Error while uploading an Image")
        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Error while Uploading Image", style: .default, handler: nil)
        alertController.addAction(alertAction)
        self.present(alertController, animated: true, completion: nil)
        self.uploadBtn.isEnabled = true
    }
    
    
    // Progress View Ex2 -
    @IBAction func progressingBtnTapped(_ sender: Any) {
        updateProgressing()
    }
    
    @objc func updateProgressing() {
        minValue = minValue + 1.0
        progressingProgressView.progress = Float(minValue/maxValue)
        progressPercentage.text = "\(minValue)"
        if minValue < maxValue {
            perform(#selector(updateProgressing), with: nil, afterDelay: 0.2)
        }else {
            print("Stop Progressing")
            minValue = 0.0
        }
    }
    
}
