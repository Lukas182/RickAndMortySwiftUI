import Foundation

protocol CharacterRepositoryProtocol: Sendable {
    func fetchAllCharacters() async throws -> CharactersResponse
    func fetchCharactersAtPage(_ page: String) async throws -> CharactersResponse
    //func searchCharacters(withText text: String) async throws -> CharactersResponse
    func searchCharacters(withFilters filters: [URLQueryItem]) async throws -> CharactersResponse
}
