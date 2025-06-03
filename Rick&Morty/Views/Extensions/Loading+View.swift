
import SwiftUI

struct LoadingViewModifier: ViewModifier {
    @Binding var isLoading: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    ZStack {
                        Color.black.opacity(0.8)
                            .ignoresSafeArea()
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.black.opacity(0.8))
                            .frame(width: 200,height: 200)
                        VStack{
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                            Text("Loading...")
                                .foregroundStyle(.white)
                                .bold()
                                .font(.title3)
                                .fontDesign(.rounded)
                                .padding(.top,24)
                        }
                        
                       
                    }
                }
            }
    }
}

extension View {
    func loadingViewisPresent(isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingViewModifier(isLoading: isLoading))
    }
}
