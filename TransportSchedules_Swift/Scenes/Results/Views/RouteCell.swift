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
    
    private func configure(_ route: Route) {
        routeNameLabel.text = route.routeName
        transportName.text = route.transportName
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
        
    }
    
    private static func createLabel(type: RouteLabelType) -> UILabel {
        let label = UILabel()
        
        switch type {
        case .main:
            label.textColor = .black
        case .description:
            label.textColor = .activeGray
            label.font = UIFont.systemFont(ofSize: 15)
        case .secondary:
            label.textColor = .placeholderGray
            label.font = UIFont.systemFont(ofSize: 13)
        }
        
        return label
    }
}
