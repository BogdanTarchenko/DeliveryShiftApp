//
//  ReceiverViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 09.07.2024.
//

import UIKit
import SnapKit

class SenderViewController: BaseViewController, ButtonViewDelegate {
    
    init() {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Отправитель")
            return headerView
        }()
        
        super.init(iconImage: "arrow-left.pdf", headerView: headerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
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
    
    override func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
