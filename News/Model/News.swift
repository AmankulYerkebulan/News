
import Foundation
import SwiftyJSON

class News: Codable,Equatable {
    
    static func == (lhs: News, rhs: News) -> Bool {
        return lhs.url == rhs.url
    }
    
    var title       : String?
    var description : String?
    var url         : String?
    var urlImage    : String?
    var date        : String?
    
    var arrayOfNews :[News]?
    
    var totalOfNews = 0
    
    init(json: JSON) {
        self.totalOfNews = json["totalResults"].intValue
        self.arrayOfNews = json["articles"].arrayValue.map({ (json) -> News in
            return News(jsonObject: json)
        })
    }
    
    init(jsonObject: JSON) {
        self.title       = jsonObject["title"].stringValue
        self.description = jsonObject["description"].stringValue
        self.url         = jsonObject["url"].stringValue
        self.urlImage    = jsonObject["urlToImage"].stringValue
        self.date        = jsonObject["publishedAt"].stringValue
    }
    
}
