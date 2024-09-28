import UIKit

final class ResultsViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: ResultsPresenterProtocol
    
    private var routesTableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        
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
