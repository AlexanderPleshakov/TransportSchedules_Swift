import Foundation

final class DefaultStationsStorage {
    static let shared = DefaultStationsStorage()
    static let notificationName = Notification.Name("StationsLoaded")
    
    private(set) var stations: [Station] = []
    private(set) var stationsIsLoaded: Bool = false
    
    private init() {}
    
    func getAllStations() {
        let networkClient = DefaultNetworkClient()
        
        let request = StationsRequest()
        networkClient.send(
            request: request,
            type: StationsDTO.self) { [weak self] result in
                guard let self else { return }
                
                switch result {
                case .success(let stationsDTO):
                    createStationsModel(from: stationsDTO)
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    
    private func createStationsModel(from dto: StationsDTO) {
        dto.countries.forEach { country in
            let countryName = country.title
            country.regions.forEach { region in
                let regionName = region.title
                
                region.settlements.forEach { settlement in
                    let settlementName = settlement.title
                    
                    settlement.stations.forEach { station in
                        let currentStation = Station(
                            code: station.codes.yandexCode,
                            stationType: station.stationType,
                            transportType: station.transportType,
                            title: station.title,
                            countryName: countryName,
                            regionName: regionName,
                            settlementName: settlementName
                        )
                        stations.append(currentStation)
                    }
                }
            }
        }
        stationsIsLoaded = true
    
        NotificationCenter.default.post(
            name: DefaultStationsStorage.notificationName,
            object: nil
        )
    }
}
