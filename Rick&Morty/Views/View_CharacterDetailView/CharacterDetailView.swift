
import SwiftUI

struct CharacterDetailView: View {
    
    let character : Character
    
    @State private var characterDetailViewModel = CharacterDetailViewModel()
    
    var body: some View {
        TabView {
            Tab("Info", systemImage: "info") {
                InfoView(character: character)
            }
            Tab("Episodies", systemImage: "list.bullet") {
                EpisodiesView(episodies: characterDetailViewModel.episodiesBySeason)
            }
        }
        .task {
            await characterDetailViewModel.fetchEpisodies(urls: character.episode)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    CharacterDetailView(character: .sample)
}
