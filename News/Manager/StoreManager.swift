
import Foundation
import Cache

class StoreManager: NSObject {
    
    //MARK: - Variables
    
    private var storage : Storage?
    
    //MARK: - Keys
    
    private let DISKCONFIGURATIONKEY    = "DISKCONFIGURATIONKEY"

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
    
}
