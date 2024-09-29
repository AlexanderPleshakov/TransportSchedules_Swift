import Foundation

final class ResultsPresenter {
    // MARK: Properites
    
    weak var view: ResultsViewControllerProtocol?
    
    private(set) var routes: [Route] = []
    private let resultsService: ResultsServiceProtocol
    
    // MARK: Init
    
    init(resultsService: ResultsServiceProtocol) {
        self.resultsService = resultsService
    }
    
    convenience init() {
        self.init(resultsService: ResultsService())
    }
    
    // MARK: Methods
}

// MARK: ResultsPresenterProtocol

extension ResultsPresenter: ResultsPresenterProtocol {
    func setup() {
        resultsService.getResults { result in
            switch result {
            case .success(let routes):
                break
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
