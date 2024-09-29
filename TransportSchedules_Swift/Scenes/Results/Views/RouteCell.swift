import UIKit

final class RouteCell: UITableViewCell {
    private enum RouteLabelType {
        case main, description, secondary
    }
    
    // MARK: Properties
    
    static let reuseId = "RouteCell"
    
    private let transportImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .orange
        
        return imageView
    }()
    
    private var routeNameLabel  = RouteCell.createLabel(type: .main)
    private var transportName = RouteCell.createLabel(type: .description)
    private var transportMark = RouteCell.createLabel(type: .secondary)
    private var startDateLabel = RouteCell.createLabel(type: .secondary)
    private var finishDateLabel = RouteCell.createLabel(type: .secondary)
    private var startTimeLabel = RouteCell.createLabel(type: .main)
    private var finishTimeLabel = RouteCell.createLabel(type: .main)
    private var startStationLabel = RouteCell.createLabel(type: .description)
    private var finishStationLabel = RouteCell.createLabel(type: .description)
    private var durationLabel = RouteCell.createLabel(type: .secondary)
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func configure(_ route: Route) {
        selectionStyle = .none
        backgroundColor = .white
        
        routeNameLabel.text = route.routeName
        transportName.text = route.routeNumber
        transportMark.text = route.transportMark
        startDateLabel.text = route.startDate
        finishDateLabel.text = route.finishDate
        startTimeLabel.text = route.startTime
        finishTimeLabel.text = route.finishTime
        startStationLabel.text = route.startStation
        finishStationLabel.text = route.finishStation
        durationLabel.text = route.duration
        
        transportImageView.image = UIImage(systemName: route.transportType.rawValue)
    }
    
    private func setupViews() {
        routeNameLabel.numberOfLines = 2
        routeNameLabel.font = UIFont.systemFont(ofSize: 14)
        
        startStationLabel.numberOfLines = 5
        finishStationLabel.numberOfLines = 5
        
        [finishDateLabel, finishTimeLabel, finishStationLabel].forEach {
            $0.textAlignment = .right
        }
        
        durationLabel.font = UIFont.systemFont(ofSize: 15)
        durationLabel.textAlignment = .center
        
        [
            routeNameLabel,
            transportName,
            transportMark,
            startDateLabel,
            startTimeLabel,
            startStationLabel,
            finishDateLabel,
            finishTimeLabel,
            finishStationLabel,
            durationLabel,
            transportImageView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        activateConstraints()
    }
    
    private func activateConstraints() {
        
        NSLayoutConstraint.activate([
            transportImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            transportImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14),
            transportImageView.heightAnchor.constraint(equalToConstant: 18),
            transportImageView.widthAnchor.constraint(equalToConstant: 18),
            
            routeNameLabel.topAnchor.constraint(equalTo: transportImageView.topAnchor, constant: -2),
            routeNameLabel.leadingAnchor.constraint(equalTo: transportImageView.trailingAnchor, constant: 8),
            routeNameLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.4),
            
            transportName.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            transportName.topAnchor.constraint(equalTo: routeNameLabel.bottomAnchor, constant: 6),
            
            transportMark.leadingAnchor.constraint(equalTo: routeNameLabel.leadingAnchor),
            transportMark.topAnchor.constraint(equalTo: transportName.bottomAnchor, constant: 6),
            
            startTimeLabel.leadingAnchor.constraint(equalTo: routeNameLabel.trailingAnchor, constant: 6),
            startTimeLabel.centerYAnchor.constraint(equalTo: routeNameLabel.centerYAnchor),
            
            startDateLabel.leadingAnchor.constraint(equalTo: startTimeLabel.leadingAnchor),
            startDateLabel.bottomAnchor.constraint(equalTo: startTimeLabel.topAnchor, constant: -2),
            
            startStationLabel.leadingAnchor.constraint(equalTo: startTimeLabel.leadingAnchor),
            startStationLabel.topAnchor.constraint(equalTo: startTimeLabel.bottomAnchor, constant: 4),
            startStationLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor, constant: -2),
            
            durationLabel.leadingAnchor.constraint(equalTo: startTimeLabel.trailingAnchor, constant: 2),
            durationLabel.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
            
            finishTimeLabel.leadingAnchor.constraint(equalTo: durationLabel.trailingAnchor, constant: 2),
            finishTimeLabel.centerYAnchor.constraint(equalTo: startTimeLabel.centerYAnchor),
            finishTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            finishDateLabel.leadingAnchor.constraint(equalTo: finishTimeLabel.leadingAnchor),
            finishDateLabel.bottomAnchor.constraint(equalTo: finishTimeLabel.topAnchor, constant: -2),
            finishDateLabel.trailingAnchor.constraint(equalTo: finishTimeLabel.trailingAnchor),
            
            finishStationLabel.leadingAnchor.constraint(equalTo: finishTimeLabel.leadingAnchor),
            finishStationLabel.topAnchor.constraint(equalTo: finishTimeLabel.bottomAnchor, constant: 4),
            finishStationLabel.trailingAnchor.constraint(equalTo: finishTimeLabel.trailingAnchor),
        ])
    }
    
    private static func createLabel(type: RouteLabelType) -> UILabel {
        let label = UILabel()
        
        switch type {
        case .main:
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        case .description:
            label.textColor = .activeGray
            label.font = UIFont.systemFont(ofSize: 12)
        case .secondary:
            label.textColor = .placeholderGray
            label.font = UIFont.systemFont(ofSize: 11)
        }
        
        return label
    }
}
