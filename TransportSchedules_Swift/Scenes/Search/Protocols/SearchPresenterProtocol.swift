protocol SearchPresenterProtocol {
    func getSearchTypeName() -> String
    var stations: [Station] { get }
}
