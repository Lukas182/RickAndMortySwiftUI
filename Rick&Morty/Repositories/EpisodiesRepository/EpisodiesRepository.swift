import Foundation

struct EpisodiesRepository: EpisodiesRepositoryProtocol, NetworkInteractor {
    var session : URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    private func getEpisode(url: String) async throws -> Episode {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        return try await getJSON(for: .get(url), type: Episode.self)
    }
    
    func getInfoEpisodies(urls: [String]) async throws -> [Episode] {
        
        try await withThrowingTaskGroup(of: Episode.self, returning: [Episode].self ) { group in
            
            for url in urls {
                group.addTask {
                    let episode = try await getEpisode(url: url)
                    return episode
                }
            }
            
            var episodes: [Episode] = []
            for try await episode in group {
                episodes.append(episode)
            }
            return episodes
            
        }
        
    }
}
