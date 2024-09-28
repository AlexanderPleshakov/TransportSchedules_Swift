import UIKit

final class ResultsViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: ResultsPresenterProtocol
    
    private var routesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(RouteCell.self, forCellReuseIdentifier: RouteCell.reuseId)
        
        return table
    }()
    
    // MARK: Init
    
    init(presenter: ResultsPresenterProtocol) {
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
        title = "Москва - Тула"
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonTapped))
        backButton.image = UIImage(systemName: "chevron.left")
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        
        routesTableView.delegate = self
        routesTableView.dataSource = self
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(routesTableView)
        
        NSLayoutConstraint.activate([
            routesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            routesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            routesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            routesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: ResultsViewControllerProtocol

extension ResultsViewController: ResultsViewControllerProtocol {
    
}

// MARK: UITableViewDelegate

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
}

// MARK: UITableViewDataSource

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.routes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RouteCell.reuseId,
            for: indexPath
        ) as? RouteCell else { return UITableViewCell() }
        
        cell.configure(presenter.routes[indexPath.row])
        
        return cell
    }
}
