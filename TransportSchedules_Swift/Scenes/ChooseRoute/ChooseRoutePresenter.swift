import Foundation

final class ChooseRoutePresenter: ChooseRoutePresenterProtocol {
    weak var view: ChooseRouteViewControllerProtocol?
    private var fromStation: Station?
    private var toStation: Station?
    
    private var selectedTransport: TransportType = .any
    
    func select(transport: TransportType) {
        selectedTransport = transport
    }
    
    func getSelectedTransport() -> TransportType {
        selectedTransport
    }
    
    func getStationForSearch(with type: SearchType) -> Station? {
        type == .from ? fromStation : toStation
    }
    
    func selectStation(_ station: Station?, with type: SearchType) {
        switch type {
        case .from:
            fromStation = station
        case .to:
            toStation = station
        }
    }
    
    func switchStations() {
        (fromStation, toStation) = (toStation, fromStation)
    }
}
