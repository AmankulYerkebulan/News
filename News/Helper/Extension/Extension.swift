
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
    
    func setUpBackItem() {
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "Back")?.original, style: UIBarButtonItem.Style.plain, target: self, action: #selector(backPressed))
    }
    
    @objc func backPressed() {
        self.navigationController?.popViewController(animated: true)
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

extension UIImage {
    
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    var original: UIImage {
        get {
            return self.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        }
    }
    
}

extension UIView {
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ self.addSubview($0) })
    }
}

extension String {
    
    func stringToDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let yourDate = formatter.date(from: self)
        formatter.dateFormat = "dd.MM.yyyy"
        if let _yourDate = yourDate {
            let myStringafd = formatter.string(from: _yourDate)
            return myStringafd
        }
        return ""
    }
}
