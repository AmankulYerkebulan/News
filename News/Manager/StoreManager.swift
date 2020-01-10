
import Foundation
import Cache

class StoreManager: NSObject {
    
    //MARK: - Variables
    
    private var storage : Storage?
    
    //MARK: - Keys
    
    private let DISKCONFIGURATIONKEY    = "DISKCONFIGURATIONKEY"
    private let NEWS                    = "NEWS"

    // MARK: - Public functions
    
    class func shared() -> StoreManager {
        return sharedManager
    }
    
    private static var sharedManager: StoreManager = {
        let manager = StoreManager()
        return manager
    }()
    
    //MARK: - Init
    
    private override init() {
        super.init()
        self.setupStorage()
    }
    
    func cleanCache() {
        try? self.storage?.removeAll()
    }
    
    //MARK: - Private functions
    
    private func setupStorage() {
        
        let disk = DiskConfig(name: DISKCONFIGURATIONKEY)
        let memory = MemoryConfig(expiry: .never, countLimit: 0, totalCostLimit: 0)
        storage = try! Storage(diskConfig: disk, memoryConfig: memory)
    }
    
    //MARK: - Storage functions
    
    func saveNews(data: News,isToDelete: Bool) {
        if var news = self.getNews() {
            if isToDelete == true {
                if news.contains(data) {
                    if let index = news.index(of: data) {
                        news.remove(at: index)
                    }
                }
            } else {
                news.insert(data, at: 0)
            }
            try? storage?.setObject(news, forKey: self.NEWS)
        } else {
            try? storage?.setObject([data], forKey: self.NEWS)
        }
    }
    
    func getNews() -> [News]? {
        if ((try? storage?.object(ofType: [News].self, forKey: self.NEWS)) != nil) {
            return (try! storage?.object(ofType: [News].self, forKey: self.NEWS))
        }
        return nil
    }
    
}
