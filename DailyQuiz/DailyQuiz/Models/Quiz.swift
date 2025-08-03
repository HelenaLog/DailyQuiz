import Foundation

struct Quiz: Codable, Equatable {
    var id = UUID().uuidString
    var number: Int
    var rating: Int
    var date: Date
}
