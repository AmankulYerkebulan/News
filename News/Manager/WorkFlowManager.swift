
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
    
    func allNews(page: Int,pageSize: Int,showIndicator: Bool,onCompletion: @escaping ([News],Int,Bool) -> Void) {
        
        var path = Global.pathFor(key: "allNews")
        path     = String(format:path,page,pageSize)
        
        print("path:\(path)")
        
        ApiManager.shared.GET(path: path, showIndicator: showIndicator, parameters: nil) { (json, error) in
            print("json:\(json)")
            if json["status"].stringValue == "ok" {
                let data = News(json: json)
                onCompletion(data.arrayOfNews ?? [],data.totalOfNews,true)
            } else {
                onCompletion([],0,false)
            }
        }
    }
    
    func topNews(page: Int,pageSize: Int,showIndicator: Bool,onCompletion: @escaping ([News],Int,Bool) -> Void) {
        
        var path = Global.pathFor(key: "topNews")
        path     = String(format:path,page,pageSize)
        
        print("path:\(path)")
        
        ApiManager.shared.GET(path: path, showIndicator: showIndicator, parameters: nil) { (json, error) in
            print("json:\(json)")
            if json["status"].stringValue == "ok" {
                let data = News(json: json)
                onCompletion(data.arrayOfNews ?? [],data.totalOfNews, true)
            } else {
                onCompletion([],0,false)
            }
        }
    }
    
}
