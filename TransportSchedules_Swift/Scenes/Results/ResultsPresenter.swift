import Foundation

final class ResultsPresenter {
    weak var view: ResultsViewControllerProtocol?
    
    private(set) var routes: [Route] = []
}

// MARK: ResultsPresenterProtocol

extension ResultsPresenter: ResultsPresenterProtocol {
    
}
