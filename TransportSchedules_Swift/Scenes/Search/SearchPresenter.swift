import Foundation

enum SearchType {
    case from, to
}

final class SearchPresenter {
    // MARK: Properties
    
    weak var view: SearchViewControllerProtocol?
    private let searchType: SearchType
    
    // MARK: Init
    
    init(type: SearchType) {
        self.searchType = type
    }
}

// MARK: SearchPresenterProtocol

extension SearchPresenter: SearchPresenterProtocol {
    func getSearchTypeName() -> String {
        switch searchType {
        case .from:
            return NSLocalizedString("from", comment: "")
        case .to:
            return NSLocalizedString("to", comment: "")
        }
    }
}
