import Foundation

// MARK: - StationsDTO
struct StationsDTO: Codable {
    let countries: [Country]
}

// MARK: - Country
struct Country: Codable {
    let regions: [Region]
    let codes: CountryCodes
    let title: String
}

// MARK: - CountryCodes
struct CountryCodes: Codable {
    let yandexCode: String?

    enum CodingKeys: String, CodingKey {
        case yandexCode = "yandex_code"
    }
}

// MARK: - Region
struct Region: Codable {
    let settlements: [Settlement]
    let codes: CountryCodes
    let title: String
}

// MARK: - Settlement
struct Settlement: Codable {
    let title: String
    let codes: CountryCodes
    let stations: [StationDTO]
}

// MARK: - Station
struct StationDTO: Codable {
    let direction: String
    let codes: StationCodes
    let stationType, title: String
    let transportType: String

    enum CodingKeys: String, CodingKey {
        case direction, codes
        case stationType = "station_type"
        case title
        case transportType = "transport_type"
    }
}

// MARK: - StationCodes
struct StationCodes: Codable {
    let yandexCode: String
    let esrCode: String?

    enum CodingKeys: String, CodingKey {
        case yandexCode = "yandex_code"
        case esrCode = "esr_code"
    }
}

