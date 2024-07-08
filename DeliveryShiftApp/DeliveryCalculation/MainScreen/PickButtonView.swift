//
//  PickButtonView.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 06.07.2024.
//

import UIKit
import SnapKit

class PickButtonView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "TextSecondaryColor")
        return label
    }()
    
    private var button: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.init(named: "BorderLightColor")?.cgColor
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let icon: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "TextSecondaryColor")
        return label
    }()
    
    private let chevron: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "chevron-down.pdf"))
        return imageView
    }()
    
    private let clickableWords: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurePickButtonView()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configurePickButtonView()
    }

    private func configurePickButtonView() {
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
        }
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.height.equalTo(40)
        }
        
        button.addSubview(icon)
        icon.snp.makeConstraints { make in
            make.leading.equalTo(button.snp.leading).inset(12)
            make.centerY.equalTo(button)
        }
        
        button.addSubview(valueLabel)
        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(icon.snp.leading).inset(24)
            make.centerY.equalTo(button)
        }
        
        button.addSubview(chevron)
        chevron.snp.makeConstraints { make in
            make.trailing.equalTo(button.snp.trailing).inset(12)
            make.centerY.equalTo(button)
        }
        
        self.addSubview(clickableWords)
        clickableWords.snp.makeConstraints { make in
            make.top.equalTo(button.snp.bottom).offset(4)
            make.leading.bottom.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setIcon(icon: UIImage?) {
        self.icon.image = icon
    }
    
    func setValue(_ title: String) {
        valueLabel.text = title
    }
    
    func setClickableWords(_ words: [String]) {
        for view in clickableWords.arrangedSubviews {
            clickableWords.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        for word in words {
            let label = UILabel()
            let attributedText = NSAttributedString(string: word, attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
            label.attributedText = attributedText
            label.textColor = UIColor(named: "TextTertiaryColor")
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(wordTapped(_:)))
            label.addGestureRecognizer(tapGesture)
            clickableWords.addArrangedSubview(label)
        }
    }
    
    @objc private func buttonTapped() {
        // Открывается вьюшка с динамической таблицей
    }
    
    @objc private func wordTapped(_ sender: UITapGestureRecognizer) {
        // Выбирается город
    }
}
