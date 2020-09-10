# camera-application


## Overview
This application is part of a Final Term project deliverable for CIS:663 Biometrics.  The application is designed to detect irises in within an image.  It leverages TensorFlowLite to run inference on device.


## Requirements
- Apple computer running macOS Catalina
- Apple device running iOS 13.7
- Apple Developer ID (required to run application on device)
- Xcode command-line tools (run xcode-select --install)
- Python 3.7  
- Tensorflow 2.0
- Anaconda or Google Collab
- https://cocoapods.org/

## Xcode Setup

The project uses CocoaPods to import the required TensorFlow Lite libraries for iOS.  Here are the following steps to generate the necessary xcworkspace for the xcode project:
  - Navigate to EyeDetectionApplication directory from the root directory of the project in terminal
  - Run the command **pod install** to generate the xcworkspace
  - The output of running this command within terminal should produce the following file: 
  ![xcworkspace](/Images/xcworkspace.?raw=true "xcworkspace")
  - Run the command **open .** from the current terminal window.  This will open a finder window.
  - Navigate to `EyeDetectionApplication.xcworkspace` and double click to launch Xcode + application
  - Connect iPhone to MacBook
  - Select the EyeDetectionApplication project in the left hand navigation to open the project configuration. In the Signing section of the General tab, select your development team from the dropdown.(per Google's Docuemntation & Examples)
  -In order to build the project, you must modify the Bundle Identifier in the Identity section so that it is unique across all Xcode projects. To create a unique identifier, try adding your initials and a number to the end of the string (per Google's Docuemntation & Examples).
  -  Build and run the app in Xcode
  

## References
- https://www.tensorflow.org/lite/guide/inference
- https://www.tensorflow.org/lite/guide/ops_compatibility
- https://www.tensorflow.org/lite/guide/ops_select
- https://www.tensorflow.org/lite/guide/ios
- https://github.com/tensorflow/examples/tree/master/lite/examples/image_classification/ios


## NOTE TO PROFESSOR
 - *For this project, we decided to leverge Google's image classification example in order to save time.  As such we are using Google's ModelDataHandler class in addtion to their CVPixelBufferExtension and UIColorExtenstion.  Our progess on the project would not have been possible without Google's extension documenation and open source examples.*
