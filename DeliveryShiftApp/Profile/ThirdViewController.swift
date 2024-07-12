//
//  ThirdViewController.swift
//  test
//
//  Created by Богдан Тарченко on 05.07.2024.
//

import UIKit

class ThirdViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "В разработке..."
        label.textColor = UIColor(named: "TextPrimaryColor")
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
}
