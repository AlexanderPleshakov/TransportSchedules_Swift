import Foundation

final class ResultsPresenter {
    // MARK: Properites
    
    weak var view: ResultsViewControllerProtocol?
    
    private(set) var routes: [Route] = []
    private let resultsService: ResultsServiceProtocol
    private let routeRequestInfo: RouteRequestInfo
    
    private let timeFormatter: DateFormatter = {
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.locale = Locale(identifier: "ru_RU")
        
        return timeFormatter
    }()
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    private let isoFormatter: DateFormatter = {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXX"
        inputFormatter.locale = Locale(identifier: "ru_RU")
        
        return inputFormatter
    }()
    
    // MARK: Init
    
    init(resultsService: ResultsServiceProtocol, routeRequestInfo: RouteRequestInfo) {
        self.resultsService = resultsService
        self.routeRequestInfo = routeRequestInfo
    }
    
    convenience init(routeRequestInfo: RouteRequestInfo) {
        self.init(
            resultsService: ResultsService(),
            routeRequestInfo: routeRequestInfo
        )
    }
    
    // MARK: Methods
    
    private func getRouteTransportType(from rawValue: String) -> RouteTransportType {
        let type = TransportType(rawValue: rawValue)
        let routeType: RouteTransportType
        switch type {
        case .plane:
            routeType = .airplane
        case .train:
            routeType = .train
        case .bus:
            routeType = .bus
        case .suburban:
            routeType = .lightrail
        default:
            routeType = .any
        }
        
        return routeType
    }
    
    private func getDateAndTime(dateTime: String) -> (String, String) {
        guard let date = isoFormatter.date(from: dateTime) else {
            return ("", "")
        }
        
        let formattedDate = dateFormatter.string(from: date)
        let formattedTime = timeFormatter.string(from: date)
        
        return (formattedDate, formattedTime)
    }
    
    private func convertRoutes(from dto: RouteDTO) -> [Route] {
        dto.segments.map { segment in
            let (startDate, startTime) = getDateAndTime(dateTime: segment.departure)
            let (finishDate, finishTime) = getDateAndTime(dateTime: segment.arrival)
            return Route(
                transportType: getRouteTransportType(from: segment.thread.transportType),
                routeName: segment.thread.title ?? "",
                routeNumber: segment.thread.number ?? "",
                transportMark: segment.thread.vehicle ?? "",
                startDate: startDate,
                finishDate: finishDate,
                startTime: startTime,
                finishTime: finishTime,
                duration: getDuration(seconds: segment.duration),
                startStation: segment.from.title,
                finishStation: segment.to.title
            )
        }
    }
    
    private func getDuration(seconds: Int) -> String {
        let minutes = seconds / 60
        let hours = Double(minutes) / 60
        
        return String(format: "%.f часа", hours)
    }
}

// MARK: ResultsPresenterProtocol

extension ResultsPresenter: ResultsPresenterProtocol {
    func setup() {
        view?.startProgressHud()
        resultsService.getResults(
            transport: routeRequestInfo.transport,
            date: routeRequestInfo.date,
            from: routeRequestInfo.from,
            to: routeRequestInfo.to
        ) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let routes):
                self.routes = convertRoutes(from: routes)
                DispatchQueue.main.async { [weak self] in
                    self?.view?.reloadData(title: routes.segments.first?.thread.title ?? "")
                    self?.view?.stopProgressHud()
                }
            case .failure(let failure):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showStub()
                }
                print(failure)
            }
        }
    }
}
