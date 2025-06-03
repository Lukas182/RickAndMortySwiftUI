import Foundation

protocol NetworkInteractor{
    var session: URLSession { get }
}

extension NetworkInteractor {
    
    func getJSON<JSON: Decodable>(for request: URLRequest, type: JSON.Type) async throws(NetworkError) -> JSON {
        let (data, response) = try await session.getData(for: request)
        
        if response.statusCode != 200 {
            throw .status(response.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(JSON.self, from: data)
        } catch {
            throw .decodingFailed
        }
    }
    
}
