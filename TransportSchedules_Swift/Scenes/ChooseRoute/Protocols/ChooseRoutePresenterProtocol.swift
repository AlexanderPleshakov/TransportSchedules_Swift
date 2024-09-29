protocol ChooseRoutePresenterProtocol {
    func select(transport: TransportType)
    func getSelectedTransport() -> TransportType
    func getStationForSearch(with type: SearchType) -> Station?
    func selectStation(_ station: Station?, with type: SearchType)
    func switchStations() 
}
