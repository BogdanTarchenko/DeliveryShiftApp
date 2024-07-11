import UIKit

class BaseViewController: UIViewController {
    
    let iconImage: String
    let headerView: HeaderView
    var deliveryInformation: DeliveryInformation
    
    init(iconImage: String, headerView: HeaderView, deliveryInformation: DeliveryInformation) {
        self.iconImage = iconImage
        self.headerView = headerView
        self.deliveryInformation = deliveryInformation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 24, weight: .bold)
        ]
        
        let leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: iconImage),
            style: .plain,
            target: self,
            action: #selector(leftBarButtonTapped)
        )
        leftBarButtonItem.tintColor = UIColor(named: "IndicatorLightColor")
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        
        navigationItem.titleView = headerView
    }
    
    @objc func leftBarButtonTapped() {}
}
