//
//  ReceiverViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 09.07.2024.
//

import UIKit
import SnapKit

class SenderViewController: UIViewController, ButtonViewDelegate {
    
    let iconImage: String = "arrow-left.pdf"
    
    var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.setTitle("Отправитель")
        return headerView
    }()
    
    var surnameView: TextFieldView = {
        let surnameView = TextFieldView()
        surnameView.setPlaceHolder("Фамилия")
        return surnameView
    }()
    
    var nameView: TextFieldView = {
        let nameView = TextFieldView()
        nameView.setPlaceHolder("Имя")
        return nameView
    }()
    
    var patronymicView: TextFieldView = {
        let patronymicView = TextFieldView()
        patronymicView.setPlaceHolder("Отчество (при наличии)")
        return patronymicView
    }()
    
    var phoneNumberView: TextFieldView = {
        let phoneNumberView = TextFieldView()
        phoneNumberView.setPlaceHolder("Телефон")
        return phoneNumberView
    }()
    
    var buttonView: ButtonView = {
        let buttonView = ButtonView()
        buttonView.setButtonTitle("Продолжить")
        return buttonView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        
        buttonView.delegate = self
        
        self.view.addSubview(surnameView)
        configureSurnameView()
        
        self.view.addSubview(nameView)
        configureNameView()
        
        self.view.addSubview(patronymicView)
        configurePatronymicView()
        
        self.view.addSubview(phoneNumberView)
        configurePhoneNumberView()
        
        self.view.addSubview(buttonView)
        configureButtonView()
    }
    
    func configureSurnameView() {
        self.surnameView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
        }
    }
    
    func configureNameView() {
        self.nameView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(surnameView.snp.bottom)
        }
    }
    
    func configurePatronymicView() {
        self.patronymicView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(nameView.snp.bottom)
        }
    }
    
    func configurePhoneNumberView() {
        self.phoneNumberView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(patronymicView.snp.bottom)
        }
    }
    
    func configureButtonView() {
        self.buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(phoneNumberView.snp.bottom).offset(24)
        }
    }
    
    func didTapButton(in view: ButtonView) {
        let whereToPickUpViewController = WhereToPickUpViewController()
        navigationController?.pushViewController(whereToPickUpViewController, animated: true)
    }
    
    func configureNavigationBar() {
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
    
    @objc func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
