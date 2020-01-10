
import Foundation

struct NewsViewModel {
        
    public var news: (([News],Int,Bool,Bool)->Void)?

    public func makeRequest(with type: ContralType,page: Int,pageSize:Int,isDelayRequest: Bool,showIndicator: Bool) {
        
        switch type {
        case .main:
            WorkFlowManager.shared().allNews(page: page, pageSize: pageSize,showIndicator: showIndicator) { (data,totalCount,success) in
                self.news?(data,totalCount, isDelayRequest,success)
            }
        case .top:
            WorkFlowManager.shared().topNews(page: page, pageSize: pageSize,showIndicator: showIndicator) { (data,totalCount,success)  in
                self.news?(data,totalCount, isDelayRequest,success)
            }
        default:
            if let news = StoreManager.shared().getNews() {
                self.news?(news,0, isDelayRequest,true)
            }
        }
    }
    
}
