import Foundation

struct Episode : Identifiable, Codable {
    // I only need to get the episode name + season.. dont care about the rest of parameters
    let id: Int
    let episode : String
    let name: String
}
