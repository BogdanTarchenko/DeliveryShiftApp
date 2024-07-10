//
//  ShippedFromTableViewController.swift
//  DeliveryShiftApp
//
//  Created by Богдан Тарченко on 10.07.2024.
//

import UIKit
import SnapKit

class ShippedToTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var networkManager = NetworkManager()
    private var points: [Point] = []
    private let tableView = UITableView()

    init() {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Куда")
            return headerView
        }()
        
        super.init(iconImage: "cross.pdf", headerView: headerView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PointTableViewCell.self, forCellReuseIdentifier: "PointCell")
        view.addSubview(tableView)
        
        fetchCities()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.snp.makeConstraints { make in
            make.bottom.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.trailing.equalToSuperview().inset(16)
        }
    }

    override func leftBarButtonTapped() {
        dismiss(animated: true)
    }
    
    private func fetchCities() {
        networkManager.fetch(api: .points, resultType: DeliveryPointsResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.points = response.points
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath)
        let point = points[indexPath.row]
        cell.textLabel?.text = point.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
