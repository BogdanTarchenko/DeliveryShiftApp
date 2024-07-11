import UIKit
import SnapKit

class DataCheckViewController: BaseViewController, ButtonViewDelegate, DataCardViewDelegate {
    
    init(deliveryInformation: DeliveryInformation) {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Проверка данных")
            return headerView
        }()
        
        super.init(iconImage: "cross.pdf", headerView: headerView, deliveryInformation: deliveryInformation)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var receiverCardView: DataCardView = {
        let receiverCardView = DataCardView(dataCardType: .receiver)
        receiverCardView.setTitle("Получатель")
        receiverCardView.setFirstSubtitle("ФИО")
        receiverCardView.setSecondSubtitle("Телефон")
        return receiverCardView
    }()
    
    var senderCardView: DataCardView = {
        let senderCardView = DataCardView(dataCardType: .sender)
        senderCardView.setTitle("Отправитель")
        senderCardView.setFirstSubtitle("ФИО")
        senderCardView.setSecondSubtitle("Телефон")
        return senderCardView
    }()
    
    var senderPointCardView: DataCardView = {
        let senderPointCardView = DataCardView(dataCardType: .senderPoint)
        senderPointCardView.setTitle("Откуда забрать")
        senderPointCardView.setFirstSubtitle("Адрес")
        senderPointCardView.setSecondSubtitle("Заметка")
        return senderPointCardView
    }()
    
    var receiverPointCardView: DataCardView = {
        let receiverPointCardView = DataCardView(dataCardType: .receiverPoint)
        receiverPointCardView.setTitle("Куда доставить")
        receiverPointCardView.setFirstSubtitle("Адрес")
        receiverPointCardView.setSecondSubtitle("Заметка")
        return receiverPointCardView
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = UIColor(named: "TextPrimaryColor")
        return label
    }()
    
    var deliveryTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "TextSecondaryColor")
        return label
    }()
    
    var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: "TextSecondaryColor")
        return label
    }()
    
    var buttonView: ButtonView = {
        let buttonView = ButtonView()
        buttonView.setButtonTitle("Оформить")
        return buttonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        buttonView.delegate = self
        receiverCardView.delegate = self
        senderCardView.delegate = self
        senderPointCardView.delegate = self
        receiverPointCardView.delegate = self
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(receiverCardView)
        configureReceiverCardView()
        
        contentView.addSubview(senderCardView)
        configureSenderCardView()
        
        contentView.addSubview(senderPointCardView)
        configureSenderPointCardView()
        
        contentView.addSubview(receiverPointCardView)
        configureReceiverPointCardView()
        
        contentView.addSubview(priceLabel)
        configurePriceLabel()
        
        contentView.addSubview(deliveryTypeLabel)
        configureDeliveryTypeLabel()
        
        contentView.addSubview(deliveryTimeLabel)
        configureDeliveryTimeLabel()
        
        contentView.addSubview(buttonView)
        configureButtonView()
        
        setupScrollViewConstraints()
    }
    
    func setupScrollViewConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.height.equalTo(scrollView).priority(.low)
        }
    }
    
    func configureReceiverCardView() {
        receiverCardView.setFirstData("\(deliveryInformation.receiver?.name ?? "") \(deliveryInformation.receiver?.surname ?? "") \(deliveryInformation.receiver?.patronymic ?? "")")
        receiverCardView.setSecondData("\(deliveryInformation.receiver?.phoneNumber ?? "")")
        
        receiverCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().offset(24)
        }
    }
    
    func configureSenderCardView() {
        senderCardView.setFirstData("\(deliveryInformation.sender?.name ?? "") \(deliveryInformation.sender?.surname ?? "") \(deliveryInformation.sender?.patronymic ?? "")")
        senderCardView.setSecondData("\(deliveryInformation.sender?.phoneNumber ?? "")")
        
        senderCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(receiverCardView.snp.bottom).offset(24)
        }
    }
    
    func configureSenderPointCardView() {
        senderPointCardView.setFirstData("г. \(deliveryInformation.senderPoint?.name ?? ""), ул. \(deliveryInformation.sender?.street ?? ""), д. \(deliveryInformation.sender?.house ?? "") \(deliveryInformation.sender?.patronymic ?? "")")
        senderPointCardView.setSecondData("\(deliveryInformation.sender?.note ?? "")")
        
        senderPointCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(senderCardView.snp.bottom).offset(24)
        }
    }
    
    func configureReceiverPointCardView() {
        receiverPointCardView.setFirstData("г. \(deliveryInformation.receiverPoint?.name ?? ""), ул. \(deliveryInformation.receiver?.street ?? ""), д. \(deliveryInformation.receiver?.house ?? "") \(deliveryInformation.receiver?.patronymic ?? "")")
        receiverPointCardView.setSecondData("\(deliveryInformation.receiver?.note ?? "")")
        
        receiverPointCardView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(senderPointCardView.snp.bottom).offset(24)
        }
    }
    
    func configurePriceLabel() {
        priceLabel.text = "Итого: \(deliveryInformation.deliveryPrice ?? 0)₽"
        
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(receiverPointCardView.snp.bottom).offset(24)
        }
    }
    
    func configureDeliveryTypeLabel() {
        deliveryTypeLabel.text = "Тариф: \(deliveryInformation.deliveryType ?? "")"
        
        deliveryTypeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(priceLabel.snp.bottom).offset(16)
        }
    }
    
    func configureDeliveryTimeLabel() {
        deliveryTimeLabel.text = "Срок: \(daysString(deliveryInformation.deliveryTime ?? 0))"
        
        deliveryTimeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(deliveryTypeLabel.snp.bottom)
        }
    }
    
    func daysString(_ days: Int) -> String {
        let cases = [2, 0, 1, 1, 1, 2]
        let titles = ["рабочий день", "рабочих дня", "рабочих дней"]
        return "\(days) \(titles[(days % 100 > 4 && days % 100 < 20) ? 2 : cases[min(days % 10, 5)]])"
    }
    
    func configureButtonView() {
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(deliveryTimeLabel.snp.bottom).offset(36)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    func didTapIcon(type: DataCardType){
        switch type {
        case .receiver:
            let receiverViewController = ReceiverViewController(deliveryInformation: deliveryInformation)
            navigationController?.pushViewController(receiverViewController, animated: true)
            
        case .sender:
            let senderViewController = SenderViewController(deliveryInformation: deliveryInformation)
            navigationController?.pushViewController(senderViewController, animated: true)
            
        case .senderPoint:
            let senderPointViewController = WhereToPickUpViewController(deliveryInformation: deliveryInformation)
            navigationController?.pushViewController(senderPointViewController, animated: true)
            
        case .receiverPoint:
            let receiverPointViewController = WhereToDeliverViewController(deliveryInformation: deliveryInformation)
            navigationController?.pushViewController(receiverPointViewController, animated: true)
        }
    }
    
    func didTapButton(in view: ButtonView) {
        let dataCheckViewController = DataCheckViewController(deliveryInformation: deliveryInformation)
        navigationController?.pushViewController(dataCheckViewController, animated: true)
    }
    
    override func leftBarButtonTapped() {
        dismiss(animated: true)
    }
}
