import UIKit
import SnapKit

class ShippedToTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var networkManager = NetworkManager()
    private var points: [Point] = []
    private let tableView = UITableView()
    
    var onPointSelected: ((Point) -> Void)?
    
    init(deliveryInformation: DeliveryInformation) {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Куда")
            return headerView
        }()
        
        super.init(iconImage: "cross.pdf", headerView: headerView, deliveryInformation: deliveryInformation)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
        tableView.separatorStyle = .none
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
        let selectedPoint = points[indexPath.row]
        onPointSelected?(selectedPoint)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
    }
}
