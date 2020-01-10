
import UIKit

class NewsViewController: UIViewController {
    
    //MARK: Properties
    
    private var tableViewManager = NewsTableViewManager()
    
    private var controlType      = ContralType.main
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.cellIdentifier)
        tableView.dataSource = self.tableViewManager
        tableView.delegate = self.tableViewManager
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let refreshControl: UIRefreshControl = {
        let rc = UIRefreshControl()
        rc.addTarget(self, action: #selector(refreshIndicatorPulled), for: .valueChanged)
        return rc
    }()
    
    //MARK: Init
    
    convenience init(with type: ContralType) {
        self.init()
        
        self.controlType = type
    }
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUp()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.controlType == .top {
            self.tableViewManager.stopTimer()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch self.controlType {
        case .top:
            self.tableViewManager.delayRequest()
        case .favorite:
            self.tableViewManager.viewModel.makeRequest(with: self.controlType, page: 1, pageSize: 15, isDelayRequest: true, showIndicator: true)
        default:
            break
        }
    }
    
}

extension NewsViewController {
    
    //MARK: - Setup
    
    private func setUp() {
        
        self.navigationItem.title = self.controlType.title
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.refreshControl = self.controlType == .main ? refreshControl : nil
        self.tableViewManager.delegate = self
        self.tableViewManager.setUpViewModel(with: self.controlType)
    }
    
    //MARK: - Action
    
    @objc func refreshIndicatorPulled() {
        self.tableViewManager.refrershController()
    }
    
}

extension NewsViewController: NewsManagerDelegate {
    
    func didSelect(with data: News) {
        let vc = DetailViewController()
        vc.news = data
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
    }
    
}
