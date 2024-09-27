import UIKit

final class SegmentDayControl: UIView {
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
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
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
