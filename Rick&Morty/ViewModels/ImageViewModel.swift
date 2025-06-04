import SwiftUI

@Observable
final class ImageViewModel {
    var image : UIImage?
    var imgManager: ImageManager
    
    init(imgManager: ImageManager = .shared) {
        self.imgManager = imgManager
    }
    
    func getImage(url: URL) async {
        do {
            image = try await imgManager.image(from: url)
        } catch {
            print("Error recovering image \(error)")
        }
        
    }
    
}

@MainActor
extension ImageViewModel {
    func getImageSync(url: String?){
        if let urlString = url, let url = URL(string: urlString) {
            Task {
                await self.getImage(url: url)
            }
        }
    }
}
