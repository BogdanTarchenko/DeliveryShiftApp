//
//  HeaderView.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 08.07.2024.
//

import UIKit
import SnapKit

protocol HeaderViewDelegate: AnyObject {
    func didTapIcon()
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewDelegate?
    
    private var icon: UIImageView = {
        let icon = UIImageView()
        icon.isUserInteractionEnabled = true
        return icon
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(named: "TextPrimaryColor")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHeaderView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureHeaderView()
    }
    
    private func configureHeaderView() {
        
        self.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.trailing).offset(32)
            make.centerY.equalToSuperview()
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTapped))
        icon.addGestureRecognizer(tapGesture)
        print("добавлен рекогнайзер")
    }
    
    @objc private func iconTapped() {
        print("тапнуто")
        delegate?.didTapIcon()
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setIcon(icon: UIImage?) {
        self.icon.image = icon
    }

}
