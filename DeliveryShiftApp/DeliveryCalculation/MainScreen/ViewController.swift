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
    var packageSizeLabel = UILabel()
    
    var shippedFromView: PickButtonView = {
        let shippedFromView = PickButtonView()
        shippedFromView.setTitle("Город отправки")
        shippedFromView.setIcon(icon: UIImage(named: "marker"))
        shippedFromView.setValue("Москва")
        shippedFromView.setClickableWords(["Санкт-Петербург", "Новосибирск", "Томск"])
        return shippedFromView
    }()
    
    var shippedToView: PickButtonView = {
        let shippedToView = PickButtonView()
        shippedToView.setTitle("Город назначения")
        shippedToView.setIcon(icon: UIImage(named: "pointer"))
        shippedToView.setValue("Санкт-Петербург")
        shippedToView.setClickableWords(["Новосибирск", "Томск", "Москва"])
        return shippedToView
    }()
    var packageSizeView: PickButtonView = {
        let packageSizeView = PickButtonView()
        packageSizeView.setTitle("Размер посылки")
        packageSizeView.setIcon(icon: UIImage(named: "email.pdf"))
        packageSizeView.setValue("Конверт")
        return packageSizeView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(backgroundView, at: 0)
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
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
        
        self.contentView.addSubview(self.shippedFromView)
        configureShippedFromView()
        
        self.contentView.addSubview(self.shippedToView)
        configureShippedToView()
        
        self.contentView.addSubview(self.packageSizeView)
        configurePackageSizeView()
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
            make.height.equalTo(500)
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
        self.header.textColor = UIColor(named: "TextPrimaryColor")
        self.header.textAlignment = .center
        self.header.font = .systemFont(ofSize: 28, weight: .bold)
    }
    
    func configureCalculateButton() {
        self.calculateButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.bottom.equalTo(calculationMenu).inset(32)
            make.height.equalTo(60)
        }
        calculateButton.addTarget(self, action: #selector(showShippingMethodScreen), for: .touchUpInside)
        self.calculateButton.setTitle("Рассчитать", for: .normal)
        self.calculateButton.setTitleColor(.white, for: .normal)
        self.calculateButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        self.calculateButton.backgroundColor = UIColor(named: "ButtonColor")
        self.calculateButton.layer.cornerRadius = 30
    }
    
    @objc func showShippingMethodScreen() {
        let shippingMethodViewController = ShippingMethodViewController()
        let navController = UINavigationController(rootViewController: shippingMethodViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    func configureContentView() {
        self.contentView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(calculationMenu).inset(16)
            make.top.equalTo(calculationMenu).inset(90)
            make.bottom.equalTo(calculationMenu).inset(120)
        }
    }
    
    func configureShippedFromView() {
        self.shippedFromView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
        }
    }
    
    func configureShippedToView() {
        self.shippedToView.snp.makeConstraints { make in
            make.top.equalTo(shippedFromView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func configurePackageSizeView() {
        self.packageSizeView.snp.makeConstraints { make in
            make.top.equalTo(shippedToView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
    }
}
    
#Preview {
    ViewController()
}
