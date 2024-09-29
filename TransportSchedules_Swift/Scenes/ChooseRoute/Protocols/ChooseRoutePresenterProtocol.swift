protocol ChooseRoutePresenterProtocol {
    func select(transport: TransportType)
    func getSelectedTransport() -> TransportType
}
