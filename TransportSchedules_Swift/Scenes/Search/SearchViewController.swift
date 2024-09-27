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
    
    private let stationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        
        return searchBar
    }()
    
    private let stationsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "tableViewCell")
        tableView.backgroundColor = .white
        
        return tableView
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
        stationSearchBar.placeholder = presenter.getSearchTypeName()
        closeButton.addTarget(self, action: #selector(buttonCloseTapped), for: .touchUpInside)
        
        stationsTableView.dataSource = self
        stationsTableView.delegate = self
        
        setupViews()
    }
    
    private func setupViews() {
        [searchTitleLabel, closeButton, stationSearchBar, stationsTableView].forEach {
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
            
            stationSearchBar.topAnchor.constraint(equalTo: searchTitleLabel.bottomAnchor, constant: 20),
            stationSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stationSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stationSearchBar.heightAnchor.constraint(equalToConstant: 50),
            
            stationsTableView.topAnchor.constraint(equalTo: stationSearchBar.bottomAnchor),
            stationsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stationsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            stationsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func buttonCloseTapped() {
        self.dismiss(animated: true)
    }
    
}

// MARK: UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
}

// MARK: UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "tableViewCell",
            for: indexPath
        )
        
        return cell
    }
}

// MARK: SearchViewControllerProtocol

extension SearchViewController: SearchViewControllerProtocol {
    
}
