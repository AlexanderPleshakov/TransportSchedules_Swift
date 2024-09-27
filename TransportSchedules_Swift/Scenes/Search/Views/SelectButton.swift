import UIKit

final class SelectButton: UIButton {
    enum SelectButtonType {
        case common, calendar, onlyImage
    }
    
    private(set) var isActive = false
    
    // MARK: Init
    
    init(title: String?, type: SelectButtonType = .common, image: UIImage? = nil) {
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        setTitleColor(.black, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
        tintColor = .black
        
        switch type {
        case .common:
            setTitle(title, for: .normal)
        case .calendar:
            setTitle((title ?? "") + " ", for: .normal)
            setImage(UIImage(systemName: "calendar"), for: .normal)
            semanticContentAttribute = .forceRightToLeft
        case .onlyImage:
            setImage(image, for: .normal)
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
    
    func addCornerRadius(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
