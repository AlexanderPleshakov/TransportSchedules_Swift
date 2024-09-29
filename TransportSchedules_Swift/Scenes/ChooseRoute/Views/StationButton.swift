import UIKit

final class StationButton: UIButton {
    let firstTitle: String?
    
    init(title: String?) {
        firstTitle = title
        
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
