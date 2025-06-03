
import SwiftUI

struct LoginView: View {
    let asset = NSDataAsset(name: "rick")
    
    @Binding var isPresent: Bool
    
    @State private var gifImage: Image?
        
    var body: some View {
        VStack {

                if let gifImage {
                    gifImage
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
                        .padding(.top,64)
                        .offset(x:10)
                        
                }

                Button {
                    isPresent = false
                } label: {
                    Text("Lets go!")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .fontDesign(.rounded)
                        .font(.title)
                        .bold()
                        .padding()
                        .background() {
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.green)
                                .background() {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(Color.white.opacity(0.2))
                                }
                                
                        }
                }
                .padding(.bottom,128)
                .padding(.horizontal,16)
            Text("Rick & Morty API")
            .foregroundStyle(.white)
            .fontDesign(.rounded)
            .padding(.bottom,16)
            .font(.title2)
            .underline()
            
        }
        .padding()
        .onAppear {
            if let asset {
                let gifData = asset.data as CFData
                CGAnimateImageDataWithBlock(gifData, nil) { index, cgImage, stop in
                    self.gifImage = Image(uiImage: .init(cgImage: cgImage))
                }
            }
        }
        
        .background(Color.black)
    }
}

#Preview {
    
    @Previewable @State var isPresent = true
    
    LoginView(isPresent: $isPresent)
}
