
import SwiftUI

struct CharacterCell: View {
    var character: Character
    
    var body: some View {
        VStack{
            AsyncCharacterImage(urlImage: character.image)
                .frame(width: 120, height: 120,alignment: .top)
                .clipShape(.circle)
                .background{
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        
                }
            Text(character.name)
                .padding(.top, 10)
                .bold()
                .foregroundStyle(.mainText)
                .frame(maxHeight: .infinity)
        }
        .frame(width: 130, height: 200)
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10)
                .fill(.cellsBackground)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .foregroundStyle(.main)
        }
        .shadow(color: .mainText.opacity(0.2), radius: 10, x: 0, y: 5)
        
        
    }
}

#Preview {
    CharacterCell(character: .sample)
}
