import UIKit

final class ChoosePlaceView: UIView {
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
    
    private let fromButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            NSLocalizedString(
                "from",
                comment: ""
            ),
            for: .normal
        )
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private let toButton: UIButton = {
        let button = UIButton()
        button.setTitle(
            NSLocalizedString(
                "to",
                comment: ""
            ),
            for: .normal
        )
        button.setTitleColor(.gray, for: .normal)
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
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
    
    private func configure() {
        layer.borderColor = UIColor.gray.cgColor
        layer.cornerRadius = 6
        layer.borderWidth = 0.5
        
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
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            switchButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            switchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            switchButton.heightAnchor.constraint(equalToConstant: 44),
            switchButton.widthAnchor.constraint(equalToConstant: 44)
        ])
    }
}


