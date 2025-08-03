import Foundation

struct Answer: Identifiable {
    var id = UUID().uuidString
    var text: AttributedString
    var isCorrect: Bool
}
