//
//  ContentView.swift
//  eye-detector
//
//  Created by Brandon Hancock on 8/12/20.
//  Copyright © 2020 Brandon Hancock. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image("placeholder")
                
                Button("Open Camera") {
                    self.showSheet = true
                    }.padding().background(Color.black).cornerRadius(10)
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"),
                                    message: Text("Choose"), buttons: [
                                        .default(Text("Photo Lib")){
                                            self.showImagePicker = true
                                            self.sourceType = .photoLibrary
                                        },.default(Text("Camera")) {
                                            self.showImagePicker = true
                                            self.sourceType = .camera
                                        },.cancel()])
                }
            }
            .navigationBarTitle("Eye Detector App")
        }.sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, sourceType: self.sourceType)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
