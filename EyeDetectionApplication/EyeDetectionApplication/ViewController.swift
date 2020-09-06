//
//  ViewController.swift
//  EyeDetectionApplication
//
//  Created by Brandon Hancock on 9/5/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCaptureVideoDataOutputSampleBufferDelegate {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var searchButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detectEyesButton: UIButton!
    
    private var inputImage: UIImage?
    private var classification: String?
    private var modelDataHandler: ModelDataHandler? = ModelDataHandler(modelFileInfo: MobileNetSSD.modelInfo, labelsFileInfo: MobileNetSSD.labelsInfo)
    private var previousInferenceTimeInMilliseconds: TimeInterval = Date.distantPast.timeIntervalSince1970 * 1000
    private let delayBetweenInferenceInMilliseconds: Double = 200
    private var result: Result?
    
    var inferenceTime: Double = 0
    var wantedInputWidth: Int = 0
    var wantedInputHeight: Int = 0
    var resolution: CGSize = CGSize.zero
    var threadCountLimit: Int = 0
    var currentThreadCount: Int = 0
    
    var imageStore: ImageCache!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imageView.layer.cornerRadius = 10.0
        detectEyesButton.layer.cornerRadius = 10.0
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage.placeholder
        
        guard modelDataHandler != nil else {
          fatalError("Failed to load model")
        }
        
        
        /*Video capture on the preview Layer*/
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo

        guard let captureDevice = AVCaptureDevice.default(for: .video) else {return}
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {return}
        captureSession.addInput(input)

        captureSession.startRunning()

        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame

        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoFeedQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        print("Caught a frame: ", Date())

        guard let cvPixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {return}
        
        
        
//        runModel(onPixelBuffer: cvPixelBuffer)

//        guard let model = try? VNCoreMLModel(for: YOLOv3().model) else {return}
//        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
//            //Handle Error
//
//            print(finishedReq.results)
//
//            guard let results = finishedReq.results as? [VNDetectedObjectObservation] else {return}
//
//            guard let firstDetection = results.first else {return}
//
//            print(firstDetection.confidence, firstDetection.boundingBox, firstDetection.accessibilityLabel)
//        }
//
//        try? VNImageRequestHandler(cvPixelBuffer: cvPixelBuffer, options: [:]).perform([request])
    }
    
    @objc func runModel(onPixelBuffer pixelBuffer: CVPixelBuffer) {
        let currentTimeInMilliseconds = Date().timeIntervalSince1970 * 1000
        
        guard (currentTimeInMilliseconds - previousInferenceTimeInMilliseconds) >= delayBetweenInferenceInMilliseconds else {return}
        
        previousInferenceTimeInMilliseconds = currentTimeInMilliseconds
        result = self.modelDataHandler?.runModel(onFrame: pixelBuffer)
        
        guard let displayResult = result else {return}
        
        let width = CVPixelBufferGetWidth(pixelBuffer)
        let height = CVPixelBufferGetHeight(pixelBuffer)
        
        DispatchQueue.main.async {
            self.resolution = CGSize(width: width, height: height)
            
            var inferenceTime: Double = 0
            if let resultInferenceTime = self.result?.inferenceTime {
              inferenceTime = resultInferenceTime
            }
            
        }
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
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
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
