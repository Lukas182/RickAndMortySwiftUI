import Foundation

enum NetworkError : Error {
    case badURL
    case noData
    case decodingFailed
    case status(Int)
    case unknown(Error)
}
