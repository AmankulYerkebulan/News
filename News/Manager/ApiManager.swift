
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

final class ApiManager {
    
    //MARK: - Shared Instance
    
    static let shared = ApiManager()
    
    private var manager: SessionManager!
    
    //MARK: - Init
    
    private init(){
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        self.manager = Alamofire.SessionManager (configuration: configuration)
    }
    
    //MARK: - GET
    
    func GET(path: String,
             showIndicator:Bool,
             parameters: Parameters?,
             onCompletion: @escaping (JSON, Error?) -> Void) {
        
        if showIndicator == true {
            SVProgressHUD.show()
        }
        
        manager.request(path,
                        method: .get,
                        parameters: parameters == nil ? [:] : parameters,
                        encoding: URLEncoding.default,
                        headers: nil).responseJSON { response in
                            if showIndicator == true {
                                SVProgressHUD.dismiss()
                            }
                            switch (response.result) {
                            case .success:
                                if let jsonData = response.result.value {
                                    let json = JSON(jsonData)
                                    onCompletion(json, nil)
                                } else {
                                    onCompletion(JSON.null, nil)
                                    
                                }
                            case .failure(let error):
                                Alert.shared.show(title: "Ошибка", message: error.localizedDescription)
                            }
        }
    }
}
