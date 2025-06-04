import SwiftUI

struct InfoView : View {
    
    @Environment(\.dismiss) var dismiss
    
    let character: Character
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                AsyncCharacterImage(urlImage: character.image)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .listRowBackground(Color.clear)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(style: StrokeStyle(lineWidth: 2))
                    }
                    .padding(1)
                
                Section {
                    
                    LabeledContent("Name"){
                        Text(character.name)
                    }
                    LabeledContent("Species"){
                        Text(character.species)
                    }
                    LabeledContent("Type"){
                        Text(character.type.isEmpty ? "N/A" : character.type)
                    }
                    LabeledContent("Status"){
                        Text(character.status.rawValue)
                    }
                    LabeledContent("Gender"){
                        Text(character.gender.rawValue)
                    }
                    LabeledContent("Last known location"){
                        Text(character.location.name)
                    }
                    LabeledContent("Episodies count"){
                        Text(String(character.episode.count))
                    }
                    
                } header: {
                    Text("Character Details")
                        .font(.headline)
                        .bold()
                        .fontDesign(.rounded)
                }
                
            }
        }
        .padding()
    }
}

#Preview {
    InfoView(character: .sample )
}
