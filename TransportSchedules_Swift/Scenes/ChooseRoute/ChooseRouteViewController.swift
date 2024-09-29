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

    private let calendarView = UICalendarView()
    
    private let choosePlaceView = ChoosePlaceView()
    private var segmentedControl: SegmentDayControl?
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
        
        navigationController?.navigationItem.backButtonTitle = NSLocalizedString(
            "back",
            comment: ""
        )
        
        segmentedControl = SegmentDayControl {
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let self else { return }
                self.calendarView.layer.opacity = 1
            }
        }
        
        searchButton.addTarget(self, action: #selector(buttonSearchTapped), for: .touchUpInside)
        choosePlaceView.delegate = self
        transportSelectionPanel.delegate = self
        
        setupViews()
    }
    
    private func setupViews() {
        guard let daysControl = segmentedControl else { return }
        
        mainVStack = UIStackView(
            arrangedSubviews: [
                titleLabel,
                choosePlaceView,
                daysControl,
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
            
            daysControl.heightAnchor.constraint(equalToConstant: 50),
            transportSelectionPanel.heightAnchor.constraint(equalToConstant: 50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        daysControl.layoutIfNeeded()
        
        configureCalendar()
    }
    
    private func configureCalendar() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.fontDesign = .rounded
        calendarView.layer.cornerRadius = 12
        calendarView.backgroundColor = .systemBackground
        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        
        let selection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = selection
        calendarView.layer.opacity = 0
        
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func closeCalendarView() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self else { return }
            self.calendarView.layer.opacity = 0
        }
    }
    
    @objc private func buttonSearchTapped() {
        navigationController?.pushViewController(
            ModulesAssembly.resultsScreenBuilder(),
            animated: true
        )
    }
}

// MARK: ChooseRouteViewControllerProtocol

extension ChooseRouteViewController: ChooseRouteViewControllerProtocol {}

// MARK: ChoosePlaceViewDelegate

extension ChooseRouteViewController: ChoosePlaceViewDelegate {
    func startSearch(searchType: SearchType) {
        let searchViewController = ModulesAssembly.searchScreenBuilder(
            type: searchType,
            transport: presenter.getSelectedTransport(),
            delegate: self,
            station: presenter.getStationForSearch(with: searchType)
        )
        searchViewController.modalPresentationStyle = .pageSheet
        present(searchViewController, animated: true)
    }
}

// MARK: UICalendarSelectionSingleDateDelegate

extension ChooseRouteViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        guard let date = dateComponents?.date else { return }
        
        segmentedControl?.setDate(date: date)
        closeCalendarView()
    }
}

// MARK: TransportSelectionPanelDelegate

extension ChooseRouteViewController: TransportSelectionPanelDelegate {
    func transportSelectionPanel(didSelect transport: TransportType) {
        presenter.select(transport: transport)
    }
}

// MARK: SearchViewControllerDelegate

extension ChooseRouteViewController: SearchViewControllerDelegate {
    func searchViewController(didChange station: Station?, type: SearchType) {
        choosePlaceView.changeTitle(type: type, text: station?.title ?? "")
        presenter.selectStation(station, with: type)
    }
}


