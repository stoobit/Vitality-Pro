import AVFoundation
import SwiftUI
import Vision
import CoreML

@Observable final class CameraModel {
    let camera = Camera(device: .systemPreferredCamera!, previewLayer: .none)
    
    var viewfinderImage: Image?
    var image: Image?
    var food: Food?
    
    var isPhotosLoaded = false
    
    init() {
        Task {
            await handleCameraPreviews()
        }
        
        Task {
            await handleCameraPhotos()
        }
    }
    
    func process(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else { return }
        let ciImage = CIImage(cgImage: cgImage)
        
        let configuartion = MLModelConfiguration()
        
        guard let model = try? VNCoreMLModel(for: FoodDetection(configuration: configuartion).model) else {
            return
        }
        
        let request = VNCoreMLRequest(model: model)
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        
        try? handler.perform([request])
        
        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }
        
        guard let result = results.first else { return }
        var identifier = result.identifier
        
        if identifier == "pepperred" || identifier == "peppergreen" || identifier == "pepperyellow" {
            identifier = "pepper"
        } else if identifier == "applered" || identifier == "applegreen" {
            identifier = "apple"
        }
        
        self.food = foods.first(where: { $0.title.lowercased().contains(identifier) })
    }
    
    func handleCameraPreviews() async {
        let imageStream = camera.previewStream
            .map { $0.image }

        for await image in imageStream {
            Task { @MainActor in
                viewfinderImage = image
            }
        }
    }
    
    func handleCameraPhotos() async {
        let unpackedPhotoStream = camera.photoStream
            .compactMap { self.unpackPhoto($0) }
        
        for await photoData in unpackedPhotoStream {
            guard let img = UIImage(data: photoData.imageData) else { return } 
            
            Task { @MainActor in
                image = Image(uiImage: img)
                process(uiImage: img)
            }
        }
    }
    
    private func unpackPhoto(_ photo: AVCapturePhoto) -> PhotoData? {
        guard let imageData = photo.fileDataRepresentation() else { return nil }
        
        let photoDimensions = photo.resolvedSettings.photoDimensions
        let imageSize = (width: Int(photoDimensions.width), height: Int(photoDimensions.height))
        
        return PhotoData(imageData: imageData, imageSize: imageSize)
    }
}

fileprivate struct PhotoData {
    var imageData: Data
    var imageSize: (width: Int, height: Int)
}

fileprivate extension CIImage {
    var image: Image? {
        let ciContext = CIContext()
        guard let cgImage = ciContext.createCGImage(self, from: self.extent) else { return nil }
        return Image(decorative: cgImage, scale: 1, orientation: .up)
    }
}
