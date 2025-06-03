

import SwiftUI

struct CharacterListView: View {
    
    @Environment(CharactersViewModel.self) var characterViewModel: CharactersViewModel
    
    var body: some View {
        
        @Bindable var characterViewModel = characterViewModel
        
        ZStack{
            NavigationStack {
                SearchableGridView(characterViewModel: characterViewModel)
                    .searchable(text: $characterViewModel.text)
                    .navigationTitle("Characters")
                    .navigationDestination(for: Character.self, destination: { character in
                        CharacterDetailView(character: character)
                    })
                    .alert("Failed to load characters", isPresented: $characterViewModel.alertPresented) {
                        Button("OK :(", role: .cancel) {
                        }
                    }
            }
            LoginView(isPresent: $characterViewModel.isPresentedHome)
                .scaleEffect(characterViewModel.isPresentedHome ? 1 : 0)
                .opacity(characterViewModel.isPresentedHome ? 1 : 0)
        }
        .animation(.easeInOut, value: characterViewModel.isPresentedHome)
        .loadingViewisPresent(isLoading: $characterViewModel.loading)
        
        
    }
}
    
#Preview {
    CharacterListView()
        .environment(CharactersViewModel())
}


