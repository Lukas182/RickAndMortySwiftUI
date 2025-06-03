
import SwiftUI

struct AsyncCharacterImage: View {
    
    var urlImage: String?
    
    @State private var vmImg = ImageViewModel()
    
    var body: some View {
        if let image = vmImg.image {
            imageView(for: image)
                .resizable()
                .scaledToFit()
        }
        else {
            Image(systemName: "photo.on.rectangle.angled")
                .onAppear {
                    vmImg.getImageSync(url: urlImage)
                }
        }
        
    }
    
    private func imageView(for image: UIImage) -> Image {
        Image(uiImage: image)
    }
}

#Preview {
    AsyncCharacterImage(urlImage: Character.sample.image!)
}
