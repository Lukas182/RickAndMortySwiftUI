import Foundation

@Observable
final class CharactersViewModel {

    var characterRepository: CharacterRepositoryProtocol
    var characters: [Character] = []
    var info: Info?
    
    var text = ""
    
    var isPresentedHome = true
    
    var alertPresented = false
    var alertMessage: String?
    
    var loading = false
    
    @MainActor
    init(characterRepository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.characterRepository = characterRepository
        Task {
            await getCharacters()
        }
    }
    
    var searchTask : Task<Void, Error>?
    
}

@MainActor
extension CharactersViewModel {
    
    func getCharacters() async {
        loading = true
        defer { loading = false }
        
        do {
            
            if text.isEmpty{
                if characters.isEmpty {
                    let response = try await characterRepository.fetchAllCharacters()
                    characters = response.results
                    info = response.info
                }
            } else {
                let response = try await characterRepository.searchCharacters(withText: text)
                info = response.info
                characters = response.results
            }
            
        } catch {
            alertMessage = error.localizedDescription
            alertPresented = true
        }
    }
    
    func loadMoreCharacters() async {
        if let nextURL = info?.next , loading == false {
            do {
                loading = true
                let response = try await characterRepository.fetchCharactersAtPage(nextURL)
                loading = false
                info = response.info
                characters = characters + response.results
            } catch {
                alertMessage = error.localizedDescription
                alertPresented = true
            }
        }
    }
    
    func search() async {
        if(searchTask != nil)
        {
            searchTask?.cancel()
            searchTask = nil
        }
        
        searchTask = Task {
            do {
                try await Task.sleep(nanoseconds: 1_000_000_000)

                // Checkear si fue cancelado
                if !Task.isCancelled{
                    await self.getCharacters()
                }
            } catch {
                if error is CancellationError {
                } else {
                    print("Searching error: \(error)")
                }
            }
        }
    }
}
