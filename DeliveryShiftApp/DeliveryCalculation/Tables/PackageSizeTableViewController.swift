import UIKit
import SnapKit

class PackageSizeTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var networkManager = NetworkManager()
    private var packageTypes: [Package] = []
    private let tableView = UITableView()
    
    var onPackageSelected: ((Package) -> Void)?
    
    init(deliveryInformation: DeliveryInformation) {
        let headerView: HeaderView = {
            let headerView = HeaderView()
            headerView.setTitle("Размер посылки")
            return headerView
        }()
        
        super.init(iconImage: "chevron-down.pdf", headerView: headerView, deliveryInformation: deliveryInformation)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PackageTableViewCell.self, forCellReuseIdentifier: "PackageCell")
        view.addSubview(tableView)
        
        fetchPackages()
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
    
    private func fetchPackages() {
        networkManager.fetch(api: .types, resultType: DeliveryPackageTypesResponse.self) { [weak self] result in
            switch result {
            case .success(let response):
                self?.packageTypes = response.packages
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packageTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PackageCell", for: indexPath)
        let package = packageTypes[indexPath.row]
        cell.textLabel?.text = "\(package.name), \(package.length)х\(package.width)x\(package.height) см"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPackage = packageTypes[indexPath.row]
        onPackageSelected?(selectedPackage)
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
    }
}
