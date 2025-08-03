import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
}

struct API {
   static let scheme = "https"
   static let host = "opentdb.com"
}

enum TriviaEndpoint: Endpoint {
    case getQuestions(amount: String, type: String, category: String, difficulty: String)
    
    var path: String {
        switch self {
        case .getQuestions:
            "/api.php"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getQuestions: .GET
        }
    }
}
