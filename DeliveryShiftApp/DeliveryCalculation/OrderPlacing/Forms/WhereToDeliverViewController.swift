//
//  ReceiverViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 09.07.2024.
//

import UIKit
import SnapKit

class WhereToDeliverViewController: UIViewController, ButtonViewDelegate {
    
    let iconImage: String = "arrow-left.pdf"
    
    var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.setTitle("Куда доставить")
        return headerView
    }()
    
    var streetView: TextFieldView = {
        let streetView = TextFieldView()
        streetView.setPlaceHolder("Улица")
        return streetView
    }()
    
    var houseView: TextFieldView = {
        let houseView = TextFieldView()
        houseView.setPlaceHolder("Дом")
        return houseView
    }()
    
    var roomNumberView: TextFieldView = {
        let roomNumberView = TextFieldView()
        roomNumberView.setPlaceHolder("Квартира")
        return roomNumberView
    }()
    
    var noteView: TextFieldView = {
        let noteView = TextFieldView()
        noteView.setPlaceHolder("Заметка для курьера")
        return noteView
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
        
        self.view.addSubview(streetView)
        configureStreetView()
        
        self.view.addSubview(houseView)
        configureHouseView()
        
        self.view.addSubview(roomNumberView)
        configureRoomNumberView()
        
        self.view.addSubview(noteView)
        configureNoteView()
        
        self.view.addSubview(buttonView)
        configureButtonView()
    }
    
    func configureStreetView() {
        self.streetView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
        }
    }
    
    func configureHouseView() {
        self.houseView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(streetView.snp.bottom)
        }
    }
    
    func configureRoomNumberView() {
        self.roomNumberView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(houseView.snp.bottom)
        }
    }
    
    func configureNoteView() {
        self.noteView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(roomNumberView.snp.bottom)
        }
    }
    
    func configureButtonView() {
        self.buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(noteView.snp.bottom).offset(24)
        }
    }
    
    func didTapButton(in view: ButtonView) {
        let senderViewController = SenderViewController()
        navigationController?.pushViewController(senderViewController, animated: true)
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
