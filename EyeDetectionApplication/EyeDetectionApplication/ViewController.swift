//
//  ViewController.swift
//  EyeDetectionApplication
//
//  Created by Brandon Hancock on 9/5/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detectEyesButton: UIButton!
    
    private var inputImage: UIImage?
    private var classification: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.layer.cornerRadius = 10.0
        detectEyesButton.layer.cornerRadius = 10.0
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.placeholder
    }
    

    @IBAction func cameraButtonPressed(_ sender: Any) {
        print("Camera Button Pressed")
    
        
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            imagePicker.cameraDevice = .front
            
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        print("Search Button Pressed")
    }
    
    @IBAction func detectEyesButtonPressed(_ sender: Any) {
        print("Detect Eyes Button Pressed")
        
        
    }
    
}

extension UIImage {
    static let placeholder = UIImage(named: "placeholder.png")!
}

extension UIButton {
    func enable() {
        self.isEnabled = true
        self.backgroundColor = UIColor.systemBlue
    }
    
    func disable() {
        self.isEnabled = false
        self.backgroundColor = UIColor.lightGray
    }
}

extension UIBarButtonItem {
    func enable() {
        self.isEnabled = true
    }
    
    func disable() {
        self.isEnabled = false
    }
}

extension ViewController: UINavigationControllerDelegate, UIPickerViewDelegate, UIImagePickerControllerDelegate {
    private func getImage(cameraSource: Bool = false) {
        let photoSource: UIImagePickerController.SourceType
        photoSource = cameraSource ? .camera: .photoLibrary
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = photoSource
        
        imagePicker.mediaTypes = []
        imagePicker.mediaTypes = [kUTTypeImage as String]
        present(imagePicker, animated: true)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        inputImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        classification = nil
        
        picker.dismiss(animated: true)
        //refresh()
        
        if inputImage == nil {
            bringUpAlertView(message: "Image was malformed.")
        }
    }
    
    func bringUpAlertView(message: String? = nil) {
        let alertController = UIAlertController(title: "Error", message: "Action can not be completed", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }
}

