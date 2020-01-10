
import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properies
    
    private let mainView = NewsDetailView()
    
    var news             : News?
    
    //MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setUp()
        self.setUpNavigationItem()
    }
}

extension DetailViewController {
    
    //MARK: - Setup
    
    private func setUp() {
        
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.view.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.width.bottom.equalToSuperview()
        }
        self.setUpBackItem()
        self.navigationItem.title = "News"
        self.mainView.configure(news: news)
    }
    
    private func setUpNavigationItem() {
        
        var starImage = UIImage(named: "star")?.original
        if let news = StoreManager.shared().getNews(),
            let localNews = self.news {
            if news.contains(localNews) {
                starImage = starImage?.imageWithColor(color1: .red).original
            }
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: starImage, style: UIBarButtonItem.Style.plain, target: self, action: #selector(addToFavourite))
    }
    
    //MARK: - Actions
    
    @objc
    private func addToFavourite() {
        guard let _news = self.news else {return}
        var navImage = self.navigationItem.rightBarButtonItem?.image
        let favoriteImage = UIImage(named: "star")?.original
        if favoriteImage == navImage {
            navImage = navImage?.imageWithColor(color1: .red).original
            StoreManager.shared().saveNews(data: _news,isToDelete: false)
        } else {
            navImage = favoriteImage
            StoreManager.shared().saveNews(data: _news,isToDelete: true)
        }
        self.navigationItem.rightBarButtonItem?.image = navImage
    }
    
}

