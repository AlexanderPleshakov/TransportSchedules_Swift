import Foundation

// MARK: - RouteDTO
struct RouteDTO: Codable {
    let search: Search
    let segments: [Segment]

    enum CodingKeys: String, CodingKey {
        case search, segments
    }
}

// MARK: - Search
struct Search: Codable {
    let from, to: RouteStation
    let date: String
}

// MARK: - RouteStation
struct RouteStation: Codable {
    let type: String
    let title: String
    let shortTitle, popularTitle: String?
    let code: String
    let stationType: String
    let stationTypeName: String
    let transportType: String

    enum CodingKeys: String, CodingKey {
        case type, title
        case shortTitle = "short_title"
        case popularTitle = "popular_title"
        case code
        case stationType = "station_type"
        case stationTypeName = "station_type_name"
        case transportType = "transport_type"
    }
}

// MARK: - Segment
struct Segment: Codable {
    let thread: RouteThread
    let from, to: RouteStation
    let duration: Int
    let startDate: String
    let departure, arrival: String

    enum CodingKeys: String, CodingKey {
        case thread, from, to
        case duration
        case startDate = "start_date"
        case departure, arrival
    }
}

// MARK: - Thread
struct RouteThread: Codable {
    let number, title, shortTitle: String? 
    let vehicle: String? 
    let transportType: String
    let uid: String?

    enum CodingKeys: String, CodingKey {
        case number, title
        case shortTitle = "short_title"
        case vehicle
        case transportType = "transport_type"
        case uid
    }
}
