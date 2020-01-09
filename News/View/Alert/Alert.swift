
import Foundation
import UIKit
import SVProgressHUD

class Alert {
    
    static let shared = Alert()
    
    private init(){}
    
    private func getRoot() -> UIViewController? {
        
        guard let root = UIApplication.shared.keyWindow?.rootViewController else {
            return nil
        }
        return root
    }
    
    func show(title: String,message: String) -> Void {
        
        guard let root = getRoot() else {
            return
        }
        
        SVProgressHUD.dismiss()
        root.showAlert(title: title, message: message) {}
    }
}
