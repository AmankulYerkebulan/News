
import Foundation
import UIKit
import SnapKit

class NewsDetailView: UIView {
    
    //MARK: - Properties
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
    }()
    
    private lazy var titleLbl:UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .boldSystemFont(ofSize: 24.width)
        view.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1529411765, alpha: 1)
        return view
    }()
    
    private lazy var descriptionTxtView: UITextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = .systemFont(ofSize: 16.width)
        view.textColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1529411765, alpha: 1)
        view.backgroundColor = .clear
        view.textAlignment = .left
        view.isEditable = false
        view.dataDetectorTypes = .all
        view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return view
    }()
    
    //MARK: - Init
    
    convenience init() {
        
        self.init(frame: CGRect(x:0,y: 0,width: UIScreen.main.bounds.width,height: UIScreen.main.bounds.height - 45))
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    private func commonInit() {
        clipsToBounds = true
        
        setUpConstrains()
    }
}

extension NewsDetailView {
    
    //MARK: - Setup
    
    func configure(news: News?) {
        if let _news = news,
            let url = _news.url,
            let urlImage = _news.urlImage {
            
            self.imageView.kf.setImage(with: URL(string: urlImage))
            self.titleLbl.text = _news.title
            self.descriptionTxtView.text = (_news.description ?? "") + "\n\n\(url)"
        }
    }
    
    private func setUpConstrains() {
        
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        let scrollView = UIScrollView()
        
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.alwaysBounceVertical = true
        addSubview(scrollView)
        
        scrollView.frame = self.bounds
        
        let contentView = UIView()
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self)
        }
        
        contentView.addSubviews([imageView,descriptionTxtView,titleLbl])
        
        imageView.snp.makeConstraints { (imageView) in
            imageView.top.equalTo(contentView.snp.top)
            imageView.width.equalToSuperview()
            imageView.height.equalTo(190.width)
        }
        
        titleLbl.snp.makeConstraints { (titleLbl) in
            titleLbl.top.equalTo(self.imageView.snp.bottom).offset(15.width)
            titleLbl.left.equalToSuperview().offset(16.width)
            titleLbl.right.equalToSuperview().offset(-16.width)
        }
    
        descriptionTxtView.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).inset(-16.width)
            make.left.equalTo(titleLbl.snp.left).offset(-5)
            make.right.equalTo(titleLbl.snp.right)
            make.bottom.equalTo(contentView.snp.bottom).offset(-60.width)
        }
    }
}

