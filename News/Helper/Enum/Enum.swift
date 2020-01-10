
import Foundation

enum ContralType {
    case main
    case top
    case favorite
    
    var title: String {
        switch self {
        case .main:
            return Constant.news
        case .top:
            return Constant.top
        default:
            return Constant.favorite
        }
    }
}
