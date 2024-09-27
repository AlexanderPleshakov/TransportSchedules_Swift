import UIKit

final class ChooseRouteViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: ChooseRoutePresenterProtocol
    
    private var mainVStack: UIStackView?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = NSLocalizedString(
            "searchTitle",
            comment: ""
        )
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        return label
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(
            NSLocalizedString("search", comment: ""),
            for: .normal
        )
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 6
        
        return button
    }()
    
    private let choosePlaceView = ChoosePlaceView()
    private let segmentedControl = SegmentDayControl(frame: .zero)
    private let transportSelectionPanel = TransportSelectionPanel()
    
    // MARK: Init
    
    init(presenter: ChooseRoutePresenterProtocol) {
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
        
        mainVStack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                choosePlaceView,
                segmentedControl,
                transportSelectionPanel,
                searchButton
            ]
        )
        guard let mainVStack else { return }
        mainVStack.axis = .vertical
        mainVStack.alignment = .fill
        mainVStack.spacing = 16
        
        mainVStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainVStack)
        
        NSLayoutConstraint.activate([
            mainVStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainVStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            mainVStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            segmentedControl.heightAnchor.constraint(equalToConstant: 50),
            transportSelectionPanel.heightAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        segmentedControl.layoutIfNeeded()
    }
}

