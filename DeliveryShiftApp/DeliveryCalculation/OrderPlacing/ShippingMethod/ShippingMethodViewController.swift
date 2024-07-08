//
//  ShippingMethodViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 08.07.2024.
//

import UIKit
import SnapKit

class ShippingMethodViewController: UIViewController, HeaderViewDelegate {
    
    var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.setIcon(icon: UIImage(named: "cross.pdf"))
        headerView.setTitle("Способ отправки")
        return headerView
    }()
    
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
        
        headerView.delegate = self
        print("делегат поставлен")
        
        self.view.addSubview(headerView)
        configureHeaderView()
        
        self.view.addSubview(expressDeliveryView)
        configureExpressDeliveryView()
        
        self.view.addSubview(usualDeliveryView)
        configureUsualDeliveryView()
    }
    
    func didTapIcon() {
        print("тапнуто")
        self.dismiss(animated: true)
    }
    
    func configureHeaderView() {
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
        }
    }
    
    func configureExpressDeliveryView() {
        self.expressDeliveryView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(headerView.snp.bottom).offset(36)
        }
    }
    
    func configureUsualDeliveryView() {
        self.usualDeliveryView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(expressDeliveryView.snp.bottom).offset(24)
        }
    }
}
