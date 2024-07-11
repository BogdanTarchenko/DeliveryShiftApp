import UIKit
import SnapKit

class ShippingMethodViewController: BaseViewController, DeliveryTypeViewDelegate {
    private let networkManager = NetworkManager()
    
    init(deliveryInformation: DeliveryInformation) {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Способ отправки")
            return headerView
        }()
        
        super.init(iconImage: "cross.pdf", headerView: headerView, deliveryInformation: deliveryInformation)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var expressDeliveryView: DeliveryTypeView = {
        let expressDeliveryView = DeliveryTypeView(deliveryType: .express)
        expressDeliveryView.setTitle("Экспресс доставка до двери")
        expressDeliveryView.setIcon(icon: UIImage(named: "express-delivery.pdf"))
        return expressDeliveryView
    }()
    
    var usualDeliveryView: DeliveryTypeView = {
        let expressDeliveryView = DeliveryTypeView(deliveryType: .usual)
        expressDeliveryView.setTitle("Обычная доставка")
        expressDeliveryView.setIcon(icon: UIImage(named: "usual-delivery.pdf"))
        return expressDeliveryView
    }()
    
    var deliveryExpressPrice: Int?
    var deliveryUsualPrice: Int?
    var deliveryExpressTime: Int?
    var deliveryUsualTime: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        createDeliveryRequest()
        
        expressDeliveryView.delegate = self
        usualDeliveryView.delegate = self
        
        self.view.addSubview(expressDeliveryView)
        configureExpressDeliveryView()
        
        self.view.addSubview(usualDeliveryView)
        configureUsualDeliveryView()
    }
    
    func configureExpressDeliveryView() {
        self.expressDeliveryView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(36)
        }
    }
    
    func configureUsualDeliveryView() {
        self.usualDeliveryView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(expressDeliveryView.snp.bottom).offset(24)
        }
    }
    
    func createDeliveryRequest() {
        guard let senderPoint = deliveryInformation.senderPoint else {return}
        guard let receiverPoint = deliveryInformation.receiverPoint else {return}
        guard let packageType = deliveryInformation.packageType else {return}
        
        let senderPointRequest = PointRequest(latitude: senderPoint.latitude, longitude: senderPoint.longitude)
        let receiverPointRequest = PointRequest(latitude: receiverPoint.latitude, longitude: receiverPoint.longitude)
        let packageTypeRequest = PackageRequest(length: packageType.length, width: packageType.width, weight: packageType.weight, height: packageType.height)
        
        let deliveryCalcRequest = DeliveryCalcRequest(package: packageTypeRequest, senderPoint: senderPointRequest, receiverPoint: receiverPointRequest)
        
        networkManager.fetch(api: .calc(request: deliveryCalcRequest), resultType: DeliveryCalcResponse.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let usualPrice = response.options[0].price
                    self.usualDeliveryView.setPrice("\(usualPrice) ₽")
                    self.deliveryUsualPrice = usualPrice
                    
                    let usualTime = response.options[0].days
                    self.usualDeliveryView.setDeliveryTime("\(self.daysString(usualTime))")
                    self.deliveryUsualTime = usualTime
                    
                    let expressPrice = response.options[1].price
                    self.expressDeliveryView.setPrice("\(expressPrice) ₽")
                    self.deliveryExpressPrice = expressPrice
                    
                    let expressTime = response.options[1].days
                    self.expressDeliveryView.setDeliveryTime("\(self.daysString(expressTime))")
                    self.deliveryExpressTime = expressTime
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func daysString(_ days: Int) -> String {
        let cases = [2, 0, 1, 1, 1, 2]
        let titles = ["рабочий день", "рабочих дня", "рабочих дней"]
        return "\(days) \(titles[(days % 100 > 4 && days % 100 < 20) ? 2 : cases[min(days % 10, 5)]])"
    }
    
    func didTapButton(type: DeliveryType) {
        switch type {
        case .express:
            deliveryInformation.deliveryType = "Экспресс доставка до двери"
            deliveryInformation.deliveryPrice = deliveryExpressPrice
            deliveryInformation.deliveryTime = deliveryExpressTime
        case .usual:
            deliveryInformation.deliveryType = "Обычная доставка"
            deliveryInformation.deliveryPrice = deliveryUsualPrice
            deliveryInformation.deliveryTime = deliveryUsualTime
        }
        let receiverViewController = ReceiverViewController(deliveryInformation: deliveryInformation)
        navigationController?.pushViewController(receiverViewController, animated: true)
    }
    
    override func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
}
