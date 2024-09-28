protocol SearchPresenterProtocol {
    func getSearchTypeName() -> String
    func needLoading() -> Bool
    
    var stations: [Station] { get }
}
