//
//  ImageDetectorViewModel.swift
//  ML Car Detector
//
//  Created by Александр Вяткин on 22.12.2021.
//

import Foundation
import CoreML
import Combine

final class ImageDetectorViewModel: ObservableObject {
    @Published var result: String = ""
    
    @Published var selectionImage = UIImage()

    private var subscribers: Set<AnyCancellable> = []
    
    private let mlModel = CarRecognition()
    
    init() {
        $selectionImage.sink { image in
           // self.selectionImage.resizeImageTo(size: CGSize(width: 224, height: 224))
            if image.size != .zero {
                self.detectImage(image: image)
            }
        }.store(in: &subscribers)
    }
    
    private func detectImage(image: UIImage) {
        
        guard let resizedImage = image.resizeImageTo(size: CGSize(width: 224, height: 224)),
              let bufferedImage = resizedImage.convertToBuffer() else { return }
        let output = try? mlModel.prediction(data: bufferedImage)
               
           if let output = output {
               let results = output.prob.sorted { $0.1 > $1.1 }
               let result = results.first
               
               self.result = "It's \(result!.key) \(String(format: "%.2f", result!.value * 100))%"
           }
    }
    
}

