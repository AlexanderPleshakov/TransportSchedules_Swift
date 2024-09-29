import Foundation

final class ChooseRoutePresenter: ChooseRoutePresenterProtocol {
    weak var view: ChooseRouteViewControllerProtocol?
    
    private var selectedTransport: TransportType = .any
    
    func select(transport: TransportType) {
        selectedTransport = transport
    }
    
    func getSelectedTransport() -> TransportType {
        selectedTransport
    }
}
