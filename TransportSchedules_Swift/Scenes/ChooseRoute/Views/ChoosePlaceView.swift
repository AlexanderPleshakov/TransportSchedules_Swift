import UIKit

final class ChoosePlaceView: UIView {
    weak var delegate: ChoosePlaceViewDelegate?
    
    private let switchButton: UIButton = {
        let button = UIButton.systemButton(
            with: UIImage(
                systemName: "arrow.up.arrow.down"
            ) ?? UIImage(),
            target: nil,
            action: nil
        )
        button.tintColor = .black   
        
        return button
    }()
    
    private let fromButton: StationButton = StationButton(
        title: NSLocalizedString(
            "from",
            comment: ""
        )
    )
    
    private let toButton: StationButton = StationButton(
        title: NSLocalizedString(
            "to",
            comment: ""
        )
    )
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondaryGray
        
        return view
    }()
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func changeTitle(type: SearchType, text: String) {
        let button = type == .from ? fromButton : toButton
        
        if !text.isEmpty {
            button.setTitle(text, for: .normal)
            button.setTitleColor(.black, for: .normal)
        } else {
            button.setTitle(button.firstTitle, for: .normal)
            button.setTitleColor(.placeholderGray, for: .normal)
        }
    }
    
    private func configure() {
        layer.borderColor = UIColor.secondaryGray.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 1.5
        
        switchButton.addTarget(
            self,
            action: #selector(buttonSwitchCitiesTapped),
            for: .touchUpInside
        )
        fromButton.addTarget(self, action: #selector(startSearchFrom), for: .touchUpInside)
        toButton.addTarget(self, action: #selector(startSearchTo), for: .touchUpInside)
        
        setupViews()
    }
    
    private func setupViews() {
        [switchButton, fromButton, toButton, separatorView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            fromButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            fromButton.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            fromButton.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: -12),
            fromButton.bottomAnchor.constraint(equalTo: separatorView.topAnchor, constant: -8),
            
            toButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            toButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            toButton.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: -12),
            toButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            separatorView.trailingAnchor.constraint(equalTo: switchButton.leadingAnchor, constant: -12),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            switchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchButton.heightAnchor.constraint(equalToConstant: 44),
            switchButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func buttonSwitchCitiesTapped() {
        let fromCity = fromButton.currentTitle
        let toCity = toButton.currentTitle
        
        if fromButton.firstTitle != fromCity && toButton.firstTitle != toCity {
            fromButton.setTitle(toCity, for: .normal)
            toButton.setTitle(fromCity, for: .normal)
        } else if fromButton.firstTitle == fromCity && toButton.firstTitle != toCity {
            fromButton.setTitle(toCity, for: .normal)
            toButton.setTitle(toButton.firstTitle, for: .normal)
        } else if fromButton.firstTitle != fromCity && toButton.firstTitle == toCity {
            fromButton.setTitle(fromButton.firstTitle, for: .normal)
            toButton.setTitle(fromCity, for: .normal)
        }
    }
    
    @objc private func startSearchFrom() {
        delegate?.startSearch(searchType: .from)
    }
    
    @objc private func startSearchTo() {
        delegate?.startSearch(searchType: .to)
    }
}


