import Foundation

protocol APIServiceType {
    func fetchQuestions() async throws -> Trivia
}

final class TriviaNetworkClient {
    
    static let shared = TriviaNetworkClient()
    
    // MARK: Private properties
    
    private let networkClient: NetworkClient
    
    // MARK: Init
    
    init(
        networkClient: NetworkClient = DefaultNetworkClient()
    ) {
        self.networkClient = networkClient
    }

}

extension TriviaNetworkClient: APIServiceType  {
    func fetchQuestions() async throws -> Trivia {
       try await request(TriviaEndpoint.getQuestions(amount: "5", type: "multiple", category: "9", difficulty: "easy"))
    }
}

// MARK: - Private methods

private extension TriviaNetworkClient {
    func request<T: Decodable>(_ endpoint: TriviaEndpoint) async throws -> T {
        guard let url = createURL(for: endpoint) else {
            throw NetworkError.invalidURL
        }
        print(url)
        let request = NetworkRequest(
            url: url,
            method: endpoint.method
        )
        
        return try await networkClient.sendRequest(request)
    }
    
    func createURL(for endpoint: TriviaEndpoint, with query: String? = nil) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endpoint.path
        components.queryItems = makeParameters(for: endpoint).compactMap({
            URLQueryItem(name: $0.key, value: $0.value)
        })
        return components.url
    }
    
    func makeParameters(for endpoint: TriviaEndpoint) -> [String: String] {
        var parameters = [String: String]()
        switch endpoint {
        case .getQuestions(let amount, let type, let category, let difficulty):
            parameters["amount"] = amount
            parameters["type"] = type
            parameters["category"] = category
            parameters["difficulty"] = difficulty
        }
        return parameters
    }
}
