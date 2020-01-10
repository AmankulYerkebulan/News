
import Foundation
import UIKit
import SnapKit
import Kingfisher

class NewsCell: UITableViewCell {
    
    //MARK: - Properties
    
    static var cellIdentifier = "NewsCell"
    
    private lazy var nameLbl:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var datelbl:UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return label
    }()
    
    private lazy var mainImageView:UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFill
        label.layer.cornerRadius = 6.width
        label.clipsToBounds = true
        label.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        let width = ScreenSize.SCREEN_WIDTH - 16.width - 16.width
        let height = 170.height
        let sHeight:CGFloat = 100
        let shadow = UIColor.black.withAlphaComponent(0.8).cgColor
        let bottomImageGradient = CAGradientLayer()
        bottomImageGradient.frame = CGRect(x: 0, y: height - sHeight, width: width, height: sHeight)
        bottomImageGradient.colors = [UIColor.clear.cgColor, shadow]
        label.layer.insertSublayer(bottomImageGradient, at: 0)
        return label
    }()
    
    //MARK: - Init
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.setUp()
    }
}

extension NewsCell {
    
    //MARK: - Setup
    
    func configure(with data: News?) {
        if let news = data,
            let url = news.urlImage {
            self.mainImageView.kf.setImage(with: URL(string: url))
            self.datelbl.text = news.date?.stringToDate()
            self.nameLbl.text = news.title
        }
    }
    
    private func setUp() {
        
        self.selectionStyle = .none
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.addSubview(mainImageView)
        self.mainImageView.addSubviews([nameLbl,datelbl])
        mainImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24.width)
            make.bottom.equalToSuperview()
            make.height.equalTo(170.height)
            make.left.equalToSuperview().offset(16.width)
            make.right.equalToSuperview().offset(-16.width)
        }
        self.nameLbl.snp.makeConstraints { (nameLbl) in
            nameLbl.left.equalToSuperview().offset(16.width)
            nameLbl.right.equalToSuperview().offset(-16.width)
            nameLbl.bottom.equalToSuperview().offset(-16.width)
        }
        datelbl.snp.makeConstraints { (make) in
            make.left.right.equalTo(self.nameLbl)
            make.bottom.equalTo(nameLbl.snp.top).offset(-4)
        }
    }
}
