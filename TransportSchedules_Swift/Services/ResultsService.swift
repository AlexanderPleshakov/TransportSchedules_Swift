import Foundation

protocol ResultsServiceProtocol {
    func getResults(
        transport: TransportType,
        date: Date,
        from: String,
        to: String,
        completion: @escaping (Result<RouteDTO, Error>) -> Void
    )
}

final class ResultsService: ResultsServiceProtocol {
    private let networkClient: NetworkClient
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter
    }()
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    convenience init() {
        self.init(networkClient: DefaultNetworkClient())
    }
    
    func getResults(
        transport: TransportType,
        date: Date,
        from: String,
        to: String,
        completion: @escaping (Result<RouteDTO, Error>) -> Void
    ) {
        let request = ResultsRequest(
            date: getDate(from: date),
            transport: transport.rawValue,
            fromCode: from,
            toCode: to
        )
        networkClient.send(request: request, type: RouteDTO.self) { result in
            switch result {
            case .success(let routes):
                completion(.success(routes))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    private func getDate(from date: Date) -> String {
        dateFormatter.string(from: date)
    }
}
