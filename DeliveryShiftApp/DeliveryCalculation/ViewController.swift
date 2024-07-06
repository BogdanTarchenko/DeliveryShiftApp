//
//  ViewController.swift
//  test
//
//  Created by Богдан Тарченко on 04.07.2024.
//

import SnapKit
import UIKit

class ViewController: UIViewController {
    
    var backgroundView: UIImageView = {
        let backgroundView = UIImageView(frame: .zero)
        backgroundView.image = UIImage(named: "delivery-calculation-background.pdf")
        backgroundView.contentMode = .scaleToFill
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundView
    }()
    
    var workspaceView = UIView()
    var calculationMenu = UIView()
    var header = UILabel()
    var calculateButton = UIButton()
    var contentView = UIView()
    var shippedFromLabel = UILabel()
    var shippedToLabel = UILabel()
    var packageSizeLabel = UILabel()
    var shippedFromView = PickButtonView()
    var shippedToView = PickButtonView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(backgroundView, at: 0)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBar.barTintColor = .white
            tabBar.backgroundColor = .white
        }
        
        self.view.addSubview(self.workspaceView)
        configureWorkspaceView()
        
        self.workspaceView.addSubview(self.calculationMenu)
        configureCalculationMenu()
        
        self.calculationMenu.addSubview(self.header)
        configureHeader()
        
        self.calculationMenu.addSubview(self.calculateButton)
        configureCalculateButton()
        
        self.calculationMenu.addSubview(self.contentView)
        configureContentView()
        
        self.contentView.addSubview(self.shippedFromLabel)
        configureShippedFromLabel()
        
        self.contentView.addSubview(self.shippedFromView)
        shippedFromView.setTitle("Город отправки")
        shippedFromView.setIcon(icon: UIImage(named: "marker"))
        shippedFromView.setClickableWords(["Санкт-Петербург", "Новосибирск", "Томск"])
        
        self.contentView.addSubview(self.shippedToView)
        configureShippedToView()
        shippedToView.setTitle("Город назначения")
        shippedToView.setIcon(icon: UIImage(named: "pointer"))
        shippedToView.setClickableWords(["Новосибирск", "Томск", "Москва"])
    }
    
    func configureWorkspaceView() {
        
        self.workspaceView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
    }
    
    func configureCalculationMenu() {
        
        self.calculationMenu.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(workspaceView)
            make.height.equalTo(560)
        }
        
        self.calculationMenu.backgroundColor = .white
        self.calculationMenu.layer.cornerRadius = 32
    }
    
    func configureHeader() {
        
        self.header.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.top.equalTo(calculationMenu).inset(32)
        }
        
        self.header.text = "Рассчитать доставку"
        self.header.textAlignment = .center
        self.header.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    func configureCalculateButton() {
        
        self.calculateButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.bottom.equalTo(calculationMenu).inset(32)
            make.height.equalTo(66)
        }
        
        self.calculateButton.setTitle("Рассчитать", for: .normal)
        self.calculateButton.setTitleColor(.white, for: .normal)
        self.calculateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.calculateButton.backgroundColor = UIColor(named: "ButtonColor")
        self.calculateButton.layer.cornerRadius = 32
    }
    
    func configureContentView() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.top.equalTo(calculationMenu).inset(90)
            make.bottom.equalTo(calculationMenu).inset(120)
        }
        
        //        Проверить визуально границы ContentView
        //        self.contentView.backgroundColor = .black
        
    }
    
    func configureShippedFromLabel() {
        self.shippedFromLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(contentView)
        }
        self.shippedFromLabel.text = "Город отправки"
    }
    
    func configurePickButton() {
        
        self.calculateButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.bottom.equalTo(calculationMenu).inset(32)
            make.height.equalTo(66)
        }
        
        self.calculateButton.setTitle("Рассчитать", for: .normal)
        self.calculateButton.setTitleColor(.white, for: .normal)
        self.calculateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        self.calculateButton.backgroundColor = UIColor(named: "ButtonColor")
        self.calculateButton.layer.cornerRadius = 32
    }
    
    func configureShippedToView() {
        self.shippedToView.snp.makeConstraints { make in
            make.top.equalTo(shippedFromView.snp.bottom).offset(20)
        }
    }
}
    
    #Preview {
        ViewController()
    }
