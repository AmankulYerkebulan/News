
import Foundation
import UIKit

class Global {
    
    //MARK: - Path For Links
    
    class func pathFor(key: String) -> String
    {
        if let path = Bundle.main.path(forResource: "api", ofType: "plist"),
            let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
            let path = dict[key] as! String
            let domen = dict["domen"] as! String
            let link = "\(domen)\(path)"
            return link
        }
        else { return "" }
    }
    
}

struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct Constant {
    
    static let news      = "News"
    static let top       = "TOP News"
    static let favorite  = "Favourites"
    
    static let pageSize  = 15
}
