
import Foundation
import UIKit

protocol NewsManagerDelegate:class {
    func didSelect(with data: News)
    func reloadData()
}

final class NewsTableViewManager: NSObject {
    
    //MARK: - Properties
    
    private var contralType = ContralType.main
    private var news:[News] = []
    
    private var page        = 1
    private var totalCount  = 0
    
    private var spinner     : UIActivityIndicatorView?
    
    private var cellHeightsDictionary: [IndexPath: CGFloat] = [:] //Need when table reload each 5 second, that not jump
    
    private var timer       : Timer?
    
    weak var delegate       : NewsManagerDelegate?
    var viewModel           = NewsViewModel()
    
}

extension NewsTableViewManager: UITableViewDelegate {
    
    //MARK: Tableview Delegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = self.news[indexPath.row]
        self.delegate?.didSelect(with: news)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if self.totalCount > self.news.count {
            self.setUpSpinner(tableView: tableView)
        } else {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 16.width))
        }
        self.cellHeightsDictionary[indexPath] = cell.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let height =  self.cellHeightsDictionary[indexPath] {
            return height
        }
        return UITableView.automaticDimension
    }
    
}

extension NewsTableViewManager: UITableViewDataSource {
    
    //MARK: Tableview Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return newsCell(tableView: tableView, indexPath: indexPath)
    }
}

extension NewsTableViewManager {
    
    //MARK: - Setup
    
    func setUpViewModel(with type: ContralType) {
        
        self.contralType = type
        viewModel.news = { news,totalCount,isDelayRequest,success in
            if success == true {
                self.totalCount = totalCount
                if isDelayRequest == false {
                    self.news.append(contentsOf: news)
                } else {
                    self.news = news
                }
                self.delegate?.reloadData()
            } else {
                self.spinner?.isHidden = true
            }
        }
        viewModel.makeRequest(with: type, page: page,pageSize: Constant.pageSize, isDelayRequest: false,showIndicator: true)
        self.delayRequest()
    }
    
    func delayRequest() {
        if self.contralType == .top {
            guard timer == nil else { return }
            
            self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }
    }
    
    func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc private func startTimer() {
        self.viewModel.makeRequest(with: .top, page: 1, pageSize: (self.totalCount > self.page * Constant.pageSize) ? self.page * Constant.pageSize : self.totalCount, isDelayRequest: true, showIndicator: false)
    }
    
    func refrershController() {
        self.page = 1
        self.viewModel.makeRequest(with: self.contralType, page: self.page, pageSize: Constant.pageSize, isDelayRequest: true, showIndicator: false)
    }
    
    private func setUpSpinner(tableView: UITableView) {
        
        let style: UIActivityIndicatorView.Style = .gray
        
        self.spinner = UIActivityIndicatorView(style: style)
        self.spinner!.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
        if self.news.count >= 15 && self.page >= 1 {
            self.spinner!.startAnimating()
            tableView.tableFooterView = spinner
        } else {
            tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 16.width))
        }
    }
    
}

extension NewsTableViewManager {
    
    //MARK: Functions
    
    private func newsCell(tableView: UITableView,indexPath: IndexPath) -> NewsCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.cellIdentifier, for: indexPath) as! NewsCell
        let news = self.news[indexPath.row]
        cell.configure(with: news)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard self.news.count < self.totalCount,(scrollView.contentOffset.y + scrollView.frame.size.height + 1) >= scrollView.contentSize.height else {
            return
        }
        
        page += 1
        viewModel.makeRequest(with: self.contralType, page: self.page, pageSize: Constant.pageSize, isDelayRequest: false, showIndicator: false)
    }
}
