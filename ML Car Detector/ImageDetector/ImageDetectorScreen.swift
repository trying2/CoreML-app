//
//  ImageDetectorScreen.swift
//  ML Car Detector
//
//  Created by Александр Вяткин on 22.12.2021.
//

import SwiftUI


struct ImageDetectorScreen: View {
    @StateObject var viewModel = ImageDetectorViewModel()
    
    @State private var showPopover = false
    @State var isSet = false
    
    var imagePickerButton: some View {
        Button(action: {
            showPopover.toggle()
        }) {
            Text("Choose car Image")
        }.foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
    
    var body: some View {
        VStack {
            Image(uiImage: viewModel.selectionImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
            
            imagePickerButton
            
            Text(viewModel.result)
                .font(.title)
        }.sheet(isPresented: $showPopover) {
            ImagePicker(selectedImage: $viewModel.selectionImage, didSet: $isSet)
        }
        
    }
}

struct ImageDetectorScreen_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetectorScreen()
    }
}
