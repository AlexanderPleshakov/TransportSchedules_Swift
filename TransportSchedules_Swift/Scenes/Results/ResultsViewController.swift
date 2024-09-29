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
    
    private let progressHud: UIActivityIndicatorView = {
        let progressHud = UIActivityIndicatorView(style: .medium)
        progressHud.hidesWhenStopped = true
        progressHud.color = .black
        progressHud.translatesAutoresizingMaskIntoConstraints = false
        
        return progressHud
    }()
    
    private let stubLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("stub", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        label.textColor = .black
        
        return label
    }( )
    
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
        presenter.setup()
    }
    
    // MARK: Methods
    
    private func configure() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .black
        
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
        view.addSubview(progressHud)
        view.addSubview(stubLabel)
        
        NSLayoutConstraint.activate([
            routesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            routesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            routesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            routesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            progressHud.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressHud.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: ResultsViewControllerProtocol

extension ResultsViewController: ResultsViewControllerProtocol {
    func reloadData(title: String) {
        routesTableView.reloadData()
        self.title = title
    }
    
    func stopProgressHud() {
        progressHud.stopAnimating()
    }
    
    func startProgressHud(){
        progressHud.startAnimating()
    }
    
    func showStub() {
        stopProgressHud()
        stubLabel.isHidden = false
    }
    
    func hideStub() {
        stubLabel.isHidden = true
    }
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
