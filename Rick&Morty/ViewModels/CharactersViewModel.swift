import Foundation

enum Action {
    case fetch
    case search(filters: [URLQueryItem])
}

@Observable
final class CharactersViewModel {

    var characterRepository: CharacterRepositoryProtocol
    var characters: [Character] = []
    var info: Info?
    
    var text = ""
    
    var statusFilterSelected : Character.Status? {
        didSet {
            Task {
                await getCharacters()
            }
        }
    }
    
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
    
    private func buildQueryItems() -> [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        if !text.isEmpty {
            queryItems.append(.name(text))
        }
        if let statusFilterSelected {
            queryItems.append(.status(statusFilterSelected.rawValue))
        }
        return queryItems
    }
}

@MainActor
extension CharactersViewModel {
    
    func getCharacters() async {
        loading = true
        defer { loading = false }
        
        if text.isEmpty{
            if characters.isEmpty {
                await doFetchCharacters(withAction: .fetch)
            }else{
                let queryItems = buildQueryItems()
                if queryItems.isEmpty {
                    await doFetchCharacters(withAction: .fetch)
                }else{
                    await doFetchCharacters(withAction: .search(filters: queryItems))
                }
            }
        } else {
            await doFetchCharacters(withAction: .search(filters: buildQueryItems()))
        }
    }
    
    private func doFetchCharacters(withAction: Action) async {
        switch withAction
        {
        case .fetch:
            do{
                let response = try await characterRepository.fetchAllCharacters()
                characters = response.results
                info = response.info
            } catch {
                alertMessage = error.localizedDescription
                alertPresented = true
            }
        case .search(let queryItems):
            do {
                let response = try await characterRepository.searchCharacters(withFilters: queryItems)
                info = response.info
                characters = response.results
            } catch {
                alertMessage = error.localizedDescription
                alertPresented = true
            }
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
