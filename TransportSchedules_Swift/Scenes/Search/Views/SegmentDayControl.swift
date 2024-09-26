import UIKit

final class SegmentDayControl: UIView {
    private let todayButton = DayButton(
        title: NSLocalizedString(
            "today",
            comment: ""
        )
    )
    
    private let tomorrowButton: DayButton = {
        let button = DayButton(
            title: NSLocalizedString(
                "tomorrow",
                comment: ""
            )
        )
        button.addSeparator()
        
        return button
    }()
    
    private let dateButton: DayButton = {
        let button = DayButton(
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

fileprivate final class DayButton: UIButton {
    enum DayButtonType {
        case common, calendar
    }
    
    private(set) var isActive = false
    
    // MARK: Init
    
    init(title: String?, type: DayButtonType = .common) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = .lightGray
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if type == .calendar {
            setTitle((title ?? "") + " ", for: .normal)
            setImage(UIImage(systemName: "calendar"), for: .normal)
            tintColor = .black
            semanticContentAttribute = .forceRightToLeft
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func select() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut]
        ) { [weak self] in
            self?.backgroundColor = .activeGray
            self?.setTitleColor(.white, for: .normal)
            self?.tintColor = .white
        }
        isActive = true
    }
    
    func deselect() {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: [.curveEaseInOut]
        ) { [weak self] in
            self?.backgroundColor = .lightGray
            self?.setTitleColor(.black, for: .normal)
            self?.tintColor = .black
        }
        isActive = false
    }
    
    func addSeparator() {
        let leftBorder = CALayer()
        leftBorder.backgroundColor = UIColor.separator.cgColor
        leftBorder.frame = CGRect(x: 0, y: 0, width: 0.5, height: 50)
        
        layer.addSublayer(leftBorder)
    }
}
