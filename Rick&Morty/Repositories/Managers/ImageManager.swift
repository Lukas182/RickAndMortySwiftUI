import UIKit

enum ImageStatus{
    case downloading(_ task: Task<UIImage, Error>)
    case downloaded(_ image: UIImage)
}

actor ImageManager {
    static let shared = ImageManager()
    
    var cache: [URL : ImageStatus] = [:]
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func downloadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await session.data(from: url)
        if let image = UIImage(data: data) {
            return image
        }else{
            throw URLError(.cannotDecodeContentData)
        }
    }
    
    func image(from url: URL) async throws -> UIImage {
        
        if let status = cache[url] {
            switch status {
                case .downloaded(let image): return image
                case .downloading(let task): return try await task.value
            }
        }
        
        let task = Task {
            try await downloadImage(from: url)
        }
        cache[url] = .downloading(task)
        
        do {
            let image = try await task.value
            cache[url] = .downloaded(image)
            return image
        } catch {
            cache.removeValue(forKey: url)
            throw error
        }
    }
    
}
