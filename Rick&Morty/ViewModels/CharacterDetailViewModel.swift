import SwiftUI

@Observable
final class CharacterDetailViewModel {
    
    var episodiesRepository: EpisodiesRepository
    var episodies: [Episode] = []
    
    var episodiesBySeason: [String: [Episode]] {
        Dictionary(grouping: episodies) { episode in
            String(episode.episode.prefix(3))
        }
    }
    
    init(episodiesRepository: EpisodiesRepository = EpisodiesRepository()) {
        self.episodiesRepository = episodiesRepository
    }
    
}

@MainActor
extension CharacterDetailViewModel {
    
    func fetchEpisodies(urls: [String]) async {
        do {
            episodies = try await episodiesRepository.getInfoEpisodies(urls: urls)
        } catch {
            episodies = []
        }
    }
}
