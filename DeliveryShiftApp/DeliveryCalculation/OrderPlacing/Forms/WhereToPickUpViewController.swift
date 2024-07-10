//
//  ReceiverViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 09.07.2024.
//

import UIKit
import SnapKit

class WhereToPickUpViewController: BaseViewController, ButtonViewDelegate {
    
    init() {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Откуда забрать")
            return headerView
        }()
        
        super.init(iconImage: "arrow-left.pdf", headerView: headerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }
    
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
        let whereToDeliverViewController = WhereToDeliverViewController()
        navigationController?.pushViewController(whereToDeliverViewController, animated: true)
    }
    
    override func leftBarButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
