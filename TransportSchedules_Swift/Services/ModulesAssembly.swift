import UIKit

protocol ModulesAssemblyProtocol {
    static func chooseRouteScreenBuilder() -> UIViewController
    static func searchScreenBuilder(
        type: SearchType,
        transport: TransportType,
        delegate: SearchViewControllerDelegate,
        station: Station?
    ) -> UIViewController
    static func resultsScreenBuilder(
        routeRequestInfo: RouteRequestInfo
    ) -> UIViewController
}

final class ModulesAssembly: ModulesAssemblyProtocol {
    static func chooseRouteScreenBuilder() -> UIViewController {
        let presenter = ChooseRoutePresenter()
        let viewController = ChooseRouteViewController(presenter: presenter)
        presenter.view = viewController
        
        return UINavigationController(rootViewController: viewController)
    }
    
    static func searchScreenBuilder(
        type: SearchType,
        transport: TransportType,
        delegate: SearchViewControllerDelegate,
        station: Station?
    ) -> UIViewController {
        let presenter = SearchPresenter(
            type: type,
            transport: transport,
            station: station
        )
        let viewController = SearchViewController(presenter: presenter)
        presenter.view = viewController
        viewController.delegate = delegate
        
        return viewController
    }
    
    static func resultsScreenBuilder(routeRequestInfo: RouteRequestInfo) -> UIViewController {
        let presenter = ResultsPresenter(routeRequestInfo: routeRequestInfo)
        let viewController = ResultsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
