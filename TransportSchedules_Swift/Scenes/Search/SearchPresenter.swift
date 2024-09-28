import Foundation

final class SearchPresenter {
    // MARK: Properties
    
    weak var view: SearchViewControllerProtocol?
    private let searchType: SearchType
    private(set) var stations: [Station] = []
    
    private var notificationToken: NSObjectProtocol?
    
    // MARK: Init
    
    init(type: SearchType) {
        self.searchType = type
        
        if DefaultStationsStorage.shared.stationsIsLoaded {
            self.stations = DefaultStationsStorage.shared.stations
        } else {
            notificationToken = NotificationCenter.default.addObserver(
                forName: DefaultStationsStorage.notificationName,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let self = self else { return }
                stations = DefaultStationsStorage.shared.stations
                view?.stationsWereLoaded()
            }
        }
    }
    
    deinit {
        if let token = notificationToken {
            NotificationCenter.default.removeObserver(token)
        }
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
    
    func needLoading() -> Bool {
        !DefaultStationsStorage.shared.stationsIsLoaded
    }
}
