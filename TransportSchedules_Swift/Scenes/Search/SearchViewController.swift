import UIKit

final class SearchViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: SearchPresenterProtocol
    
    private let searchTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .black
        
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.tintColor = .black
        
        return button
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
        view.backgroundColor = .white
        
        searchTitleLabel.text = presenter.getSearchTypeName()
        closeButton.addTarget(self, action: #selector(buttonCloseTapped), for: .touchUpInside)
        
        setupViews()
    }
    
    private func setupViews() {
        [searchTitleLabel, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            searchTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.heightAnchor.constraint(equalToConstant: 44),
            closeButton.widthAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    @objc private func buttonCloseTapped() {
        self.dismiss(animated: true)
    }
    
}

// MARK: SearchViewControllerProtocol

extension SearchViewController: SearchViewControllerProtocol {
    
}
