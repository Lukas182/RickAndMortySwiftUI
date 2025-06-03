import Foundation

protocol EpisodiesRepositoryProtocol {
    func getInfoEpisodies(urls: [String]) async throws -> [Episode]
}
