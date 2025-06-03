import Foundation

struct CharacterRepository: CharacterRepositoryProtocol, NetworkInteractor {
    
    var session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchAllCharacters() async throws -> CharactersResponse {
        return try await getJSON(for: .get(.getCharacters), type: CharactersResponse.self)
    }
    
    func fetchCharactersAtPage(_ page: String) async throws -> CharactersResponse {
        guard let url = URL(string: page) else {
            throw URLError(.badURL)
        }
        return try await getJSON(for: .get(url), type: CharactersResponse.self)
    }
    
    func searchCharacters(withText text: String) async throws -> CharactersResponse {
        return try await getJSON(for: .get(.searchCharacterByName(text)), type: CharactersResponse.self)
    }
}
