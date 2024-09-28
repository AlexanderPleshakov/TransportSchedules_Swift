import UIKit

protocol SegmentDayControlDelegate: AnyObject {
    
}

final class SegmentDayControl: UIView {
    weak var delegate: SegmentDayControlDelegate?
    
    private let todayButton = SelectButton(
        title: NSLocalizedString(
            "today",
            comment: ""
        )
    )
    
    private let tomorrowButton: SelectButton = {
        let button = SelectButton(
            title: NSLocalizedString(
                "tomorrow",
                comment: ""
            )
        )
        button.addSeparator()
        
        return button
    }()
    
    private let dateButton: SelectButton = {
        let button = SelectButton(
            title: NSLocalizedString(
                "date",
                comment: ""
            ), type: .calendar
        )
        button.addSeparator()
        
        return button
    }()
    
    private let onDateTap: () -> Void
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        return dateFormatter
    }()
    
    // MARK: Init
    
    init(onDateTap: @escaping () -> Void) {
        self.onDateTap = onDateTap
        
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setDate(date: Date) {
        let selectedDate = dateFormatter.string(from: date) + " "
        dateButton.setTitle(selectedDate, for: .normal)
    }
    
    private func configure() {
        layer.cornerRadius = 6
        clipsToBounds = true
        
        dateButton.addTarget(self, action: #selector(buttonDateTapped), for: .touchUpInside)
        tomorrowButton.addTarget(self, action: #selector(buttonTomorrowTapped), for: .touchUpInside)
        todayButton.addTarget(self, action: #selector(buttonTodayTapped), for: .touchUpInside)
        
        let mainHStack = UIStackView(
            arrangedSubviews: [
                todayButton,
                tomorrowButton,
                dateButton
            ]
        )
        mainHStack.axis = .horizontal
        mainHStack.spacing = 0
        mainHStack.distribution = .fillEqually
        mainHStack.alignment = .fill
        
        mainHStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainHStack)
        
        NSLayoutConstraint.activate([
            mainHStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHStack.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func deselectButtons() {
        [todayButton, tomorrowButton, dateButton].forEach { button in
            button.deselect()
        }
    }
    
    @objc private func buttonDateTapped() {
        if !dateButton.isActive {
            deselectButtons()
            dateButton.select()
        }
        
        onDateTap()
    }
    
    @objc private func buttonTomorrowTapped() {
        if !tomorrowButton.isActive {
            deselectButtons()
            tomorrowButton.select()
        }
    }
    
    @objc private func buttonTodayTapped() {
        if !todayButton.isActive {
            deselectButtons()
            todayButton.select()
        }
    }
}
