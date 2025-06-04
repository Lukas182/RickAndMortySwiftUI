
import SwiftUI

struct SearchableGridView: View {
    
    @Environment(\.isSearching) private var isSearching
    @Environment(\.dismissSearch) private var dismissSearch
    
    @Environment(CharactersViewModel.self) var characterViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 160, maximum: 190)),
    ]
    
    var body: some View {
        
        @Bindable var characterViewModel = characterViewModel
        
        VStack {
            
            HStack(spacing:16){
                ForEach(Character.Status.allCases) { status in
                    FilterButtonByType(filter: status, selectedFilter: $characterViewModel.statusFilterSelected)
                }
                Spacer()
            }
            .padding(.horizontal,24)
            .padding(.vertical,4)
        
            
            ScrollView(showsIndicators: false)
            {
                LazyVGrid(columns: columns, spacing: 22, content: {
                    ForEach(characterViewModel.characters){ character in
                        NavigationLink(value: character, label: {
                            CharacterCell(character: character)
                                .id(character.id)
                        })
                        .onAppear {
                            if character == characterViewModel.characters.last {
                                Task {
                                    await characterViewModel.loadMoreCharacters()
                                }
                            }
                        }
                        .buttonStyle(.plain)
                        
                    }
                })
                .safeAreaPadding()
            }
            .onChange(of: characterViewModel.text) { oldValue, newValue in
                if(isSearching && !characterViewModel.text.isEmpty){
                    Task {
                        await characterViewModel.search()
                    }
                }
                else {
                    dismissSearch()
                    characterViewModel.characters.removeAll()
                    Task {
                        await characterViewModel.getCharacters()
                    }
                }
            }
        }
    }
}

#Preview {
    SearchableGridView()
        .environment(CharactersViewModel(characterRepository: FakeCharacterRepository()))
}




