# camera-application

This application is part of a Final Term project deliverable for CIS:663 Biometrics.  The application is designed to detect irises in within an image.  It leverages TensorFlowLite to run inference on device.

The project uses CocoaPods to import the required TensorFlow Lite libraries for iOS.  Here are the following steps to generate the necessary xcworkspace for the xcode project:
  - Navigate to EyeDetectionApplication directory from the root directory of the project in terminal
  - Run the command **pod install** to generate the xcworkspace
  - The output of running this command within terminal should produce the following file: 
