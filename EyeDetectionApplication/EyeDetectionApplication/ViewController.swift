//
//  ViewController.swift
//  EyeDetectionApplication
//
//  Created by Brandon Hancock on 9/5/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detectEyesButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cameraButtonPressed(_ sender: Any) {
        print("Camera Button Pressed")
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        print("Search Button Pressed")
    }
    
    @IBAction func detectEyesButtonPressed(_ sender: Any) {
        print("Detect Eyes Button Pressed")
    }
    
}

