protocol SearchPresenterProtocol {
    func getSearchTypeName() -> String
    func needLoading() -> Bool
    func filterStations(on text: String)
    
    var stations: [Station] { get }
    var searchType: SearchType { get }
}
