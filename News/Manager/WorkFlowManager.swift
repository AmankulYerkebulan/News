
import Foundation
import SwiftyJSON
import UIKit
import Alamofire
import SVProgressHUD

class WorkFlowManager: NSObject {
    
    //MARK: - Variables
    
    //MARK : - Shared Instance
    
    class func shared() -> WorkFlowManager {
        
        return sharedManager
    }
    
    private static var sharedManager: WorkFlowManager = {
        
        let manager = WorkFlowManager()
        return manager
    }()
    
    //MARK: - Init
    
    private override init() { super.init() }
    
    //MARK: - GETT Requests
    
//    func listOfCity(id: String,onCompletion: @escaping ([List]) -> Void) {
//        
//        let path = Global.pathFor(key: "country")
//        print("path:\(path)")
//        ApiManager.shared.GET(path: path, showIndicator: true, parameters: nil) { (json, error) in
//            print("json:\(json)")
//            let data = List(json: json)
//            onCompletion(data.data ?? [])
//        }
//    }
    
}
