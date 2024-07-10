//
//  ShippingMethodViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 08.07.2024.
//

import UIKit
import SnapKit

class ShippingMethodViewController: BaseViewController, DeliveryTypeViewDelegate {
    
    init() {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Способ отправки")
            return headerView
        }()
        
        super.init(iconImage: "cross.pdf", headerView: headerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
    var expressDeliveryView: DeliveryTypeView = {
        let expressDeliveryView = DeliveryTypeView()
        expressDeliveryView.setTitle("Экспресс доставка до двери")
        expressDeliveryView.setPrice("780 ₽")
        expressDeliveryView.setIcon(icon: UIImage(named: "express-delivery.pdf"))
        expressDeliveryView.setDeliveryTime("1 рабочий день")
        return expressDeliveryView
    }()
    
    var usualDeliveryView: DeliveryTypeView = {
        let expressDeliveryView = DeliveryTypeView()
        expressDeliveryView.setTitle("Обычная доставка")
        expressDeliveryView.setPrice("325 ₽")
        expressDeliveryView.setIcon(icon: UIImage(named: "usual-delivery.pdf"))
        expressDeliveryView.setDeliveryTime("5 рабочих дней")
        return expressDeliveryView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
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
    
    func didTapButton(in view: DeliveryTypeView) {
        let receiverViewController = ReceiverViewController()
        navigationController?.pushViewController(receiverViewController, animated: true)
    }
    
    override func leftBarButtonTapped() {
        self.dismiss(animated: true)
    }
}
