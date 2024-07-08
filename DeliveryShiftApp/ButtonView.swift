//
//  HeaderView.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 08.07.2024.
//

import UIKit
import SnapKit

class ButtonView: UIView {
    
    private var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ButtonColor")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.layer.cornerRadius = 30
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButtonView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButtonView()
    }
    
    private func configureButtonView() {
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
    }
    
    func setButtonTitle(_ title: String) {
        button.setTitle(title, for: .normal)
    }
}
