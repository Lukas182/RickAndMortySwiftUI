import Foundation

extension URLSession {
    
    func getData(from url: URL) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse){
        do {
            let (data,response) = try await data(from: url)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.badURL
            }
            return (data,response)
        } catch let error as NetworkError{
            throw error
        } catch {
            throw .unknown(error)
        }
    }
    
    func getData(for request: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse){
        do {
            let (data,response) = try await data(for: request)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.badURL
            }
            return (data,response)
        } catch let error as NetworkError{
            throw error
        } catch {
            throw .unknown(error)
        }
        
    }
    
}
