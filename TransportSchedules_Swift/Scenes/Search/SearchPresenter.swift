import Foundation

final class SearchPresenter {
    // MARK: Properties
    
    weak var view: SearchViewControllerProtocol?
    private let searchType: SearchType
    private let transport: TransportType
    private var allStations: [Station] = []
    private(set) var stations: [Station] = []
    
    private var notificationToken: NSObjectProtocol?
    
    // MARK: Init
    
    init(type: SearchType, transport: TransportType) {
        self.searchType = type
        self.transport = transport
        
        if DefaultStationsStorage.shared.stationsIsLoaded {
            self.allStations = DefaultStationsStorage.shared.stations
            self.stations = allStations
        } else {
            notificationToken = NotificationCenter.default.addObserver(
                forName: DefaultStationsStorage.notificationName,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                guard let self = self else { return }
                allStations = DefaultStationsStorage.shared.stations
                self.stations = allStations
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
    
    func filterStations(on text: String) {
        if text.isEmpty {
            stations = allStations
        } else {
            stations = allStations.filter {
                if transport == .any {
                    $0.title.lowercased().contains(text.lowercased())
                } else {
                    $0.title.lowercased().contains(text.lowercased()) &&
                    $0.transportType == transport.rawValue
                }
            }
        }
        view?.reloadData()
    }
}
