//
//  ShippedFromTableViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 10.07.2024.
//

import UIKit
import SnapKit

class ShippedFromTableViewController: UIViewController {
    
    let iconImage: String = "cross.pdf"
    
    var headerView: HeaderView = {
        let headerView = HeaderView()
        headerView.setTitle("Куда")
        return headerView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
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
        dismiss(animated: true)
    }
    
}

