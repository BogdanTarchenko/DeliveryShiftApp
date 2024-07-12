import UIKit
import SnapKit

class SecondViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "В разработке..."
        label.textColor = UIColor(named: "TextPrimaryColor")
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
