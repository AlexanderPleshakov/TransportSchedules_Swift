import UIKit

final class CityButton: UIButton {
    init(title: String?) {
        super.init(frame: .zero)
        
        setTitleColor(.placeholderGray, for: .normal)
        contentHorizontalAlignment = .leading
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
