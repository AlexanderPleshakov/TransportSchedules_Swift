import UIKit

final class SearchViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: SearchPresenterProtocol
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = NSLocalizedString(
            "searchTitle",
            comment: ""
        )
        
        return label
    }()
    
    // MARK: Init
    
    init(presenter: SearchPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: Methods
    
    private func configure() {
        
    }
}

