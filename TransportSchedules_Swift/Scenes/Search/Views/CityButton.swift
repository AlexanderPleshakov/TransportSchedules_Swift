import UIKit

final class CityButton: UIButton {
    init(title: String?) {
        super.init(frame: .zero)
        
        setTitleColor(.gray, for: .normal)
        contentHorizontalAlignment = .leading
        setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
