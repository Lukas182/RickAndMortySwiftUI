import Foundation

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

extension URLRequest {
    static func get(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethod.get.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    
}
