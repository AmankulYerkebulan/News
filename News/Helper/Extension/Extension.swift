
import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, complition: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            complition()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Int {
    
    var width: CGFloat {
        get {
            return  ScreenSize.SCREEN_WIDTH / (375 / CGFloat(self))
        }
    }
    
    var height: CGFloat {
        get {
            return  ScreenSize.SCREEN_HEIGHT / (812 / CGFloat(self))
        }
    }
    
}
