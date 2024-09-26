import UIKit

final class SearchViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: SearchPresenterProtocol
    
    private var mainVStack: UIStackView?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = NSLocalizedString(
            "searchTitle",
            comment: ""
        )
        label.numberOfLines = 2
        
        return label
    }()
    
    private let choosePlaceView = ChoosePlaceView()
    
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
        view.backgroundColor = .white
        
        mainVStack = UIStackView(arrangedSubviews: [titleLabel, choosePlaceView])
        guard let mainVStack else { return }
        mainVStack.axis = .vertical
        mainVStack.alignment = .fill
        mainVStack.spacing = 20
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainVStack)
        
        NSLayoutConstraint.activate([
            mainVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
}

