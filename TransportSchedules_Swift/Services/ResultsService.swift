import Foundation

protocol ResultsServiceProtocol {
    func getResults(completion: @escaping (Result<RouteDTO, Error>) -> Void)
}

final class ResultsService: ResultsServiceProtocol {
    private let networkClient: NetworkClient
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    convenience init() {
        self.init(networkClient: DefaultNetworkClient())
    }
    
    func getResults(completion: @escaping (Result<RouteDTO, Error>) -> Void) {
        let request = ResultsRequest()
        networkClient.send(request: request, type: RouteDTO.self) { result in
            switch result {
            case .success(let routes):
                completion(.success(routes))
                print(routes)
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
