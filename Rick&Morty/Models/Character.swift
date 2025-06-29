import Foundation

struct Character: Codable, Identifiable, Equatable, Hashable {
    
    let id: Int
    let name: String
    let status: Character.Status
    let species: String
    let type: String
    let gender: Character.Gender
    let origin: Character.Location
    let location: Character.Location
    let image: String?
    let episode: [String]
    let url: String
    let created: String

    enum Gender: String, Codable, Hashable{
        case male = "Male"
        case female = "Female"
        case genderLess = "Genderless"
        case unknown = "unknown"
    }
    
    enum Status: String, CaseIterable,Codable, Identifiable {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
        
        var id: Self { self }
    }
    
    struct Location: Codable, Hashable {
        let name: String
        let url: String?
    }
    
    static func == (lhs: Character, rhs: Character) -> Bool {
        lhs.id == rhs.id
    }
}
