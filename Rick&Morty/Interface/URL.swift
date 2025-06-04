import Foundation

extension URL {
    static let baseURL = URL(string: "https://rickandmortyapi.com/api")!
}

extension URL {
    
    static let getCharacters = baseURL.appendingPathComponent("character")
    static let getLocations = baseURL.appendingPathComponent("location")
    static let getEpisodes = baseURL.appendingPathComponent("episode")
    
    static func searchCharacterWithParameters(_ parameters: [URLQueryItem]) -> URL {
        getCharacters.appending(queryItems: parameters)
    }
    
}

extension URLQueryItem {
    
    static func name(_ name: String) -> URLQueryItem {
        URLQueryItem(name: "name", value: name)
    }
    
    static func status(_ status: String) -> URLQueryItem {
        URLQueryItem(name: "status", value: status)
    }
}
