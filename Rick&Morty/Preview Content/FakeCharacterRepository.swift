import Foundation

struct FakeCharacterRepository: CharacterRepositoryProtocol {
    func searchCharacters(withFilters filters: [URLQueryItem]) async throws -> CharactersResponse {
        let url = Bundle.main.url(forResource: "test_data", withExtension: "json")
        
        guard let urlData = url else {
            fatalError("Could not find file")
        }
        
        return try JSONDecoder().decode(CharactersResponse.self, from: Data(contentsOf: urlData))
    }
    
    func fetchCharactersAtPage(_ page: String) async throws -> CharactersResponse {
        let url = Bundle.main.url(forResource: "test_data", withExtension: "json")
        
        guard let urlData = url else {
            fatalError("Could not find file")
        }
        
        return try JSONDecoder().decode(CharactersResponse.self, from: Data(contentsOf: urlData))
    }
    
    func fetchAllCharacters() async throws -> CharactersResponse {
        let url = Bundle.main.url(forResource: "test_data", withExtension: "json")
        
        guard let urlData = url else {
            fatalError("Could not find file")
        }
        
        return try JSONDecoder().decode(CharactersResponse.self, from: Data(contentsOf: urlData))
    }
    
}
