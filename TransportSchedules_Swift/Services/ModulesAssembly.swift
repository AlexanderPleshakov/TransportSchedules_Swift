import UIKit

protocol ModulesAssemblyProtocol {
    static func chooseRouteScreenBuilder() -> UIViewController
    static func searchScreenBuilder(
        type: SearchType,
        transport: TransportType,
        delegate: SearchViewControllerDelegate
    ) -> UIViewController
    static func resultsScreenBuilder() -> UIViewController
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
        delegate: SearchViewControllerDelegate
    ) -> UIViewController {
        let presenter = SearchPresenter(type: type, transport: transport)
        let viewController = SearchViewController(presenter: presenter)
        presenter.view = viewController
        viewController.delegate = delegate
        
        return viewController
    }
    
    static func resultsScreenBuilder() -> UIViewController {
        let presenter = ResultsPresenter()
        let viewController = ResultsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
