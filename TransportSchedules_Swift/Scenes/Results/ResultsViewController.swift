import UIKit

final class ResultsViewController: UIViewController {
    // MARK: Properties
    
    private let presenter: ResultsPresenterProtocol
    
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
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
}

// MARK: ResultsViewControllerProtocol

extension ResultsViewController: ResultsViewControllerProtocol {
    
}
