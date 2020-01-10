
import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Controllers
    
    private let mainVc    = NewsViewController(with: ContralType.main)
    private let favVc     = NewsViewController(with: ContralType.favorite)
    private let topVc     = NewsViewController(with: ContralType.top)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        self.setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        
        let homeImage = UIImage(named: "home")
        let starImage = UIImage(named: "star")
        let topImage = UIImage(named: "top")
        
        mainVc.tabBarItem = UITabBarItem(title: nil, image: homeImage, selectedImage: homeImage?.imageWithColor(color1: #colorLiteral(red: 0.1215686275, green: 0.7176470588, blue: 0.3764705882, alpha: 1)).original)
        favVc.tabBarItem = UITabBarItem(title: nil, image: starImage, selectedImage: starImage?.imageWithColor(color1: #colorLiteral(red: 0.1215686275, green: 0.7176470588, blue: 0.3764705882, alpha: 1)).original)
        topVc.tabBarItem = UITabBarItem(title: nil, image: topImage, selectedImage: topImage?.imageWithColor(color1: #colorLiteral(red: 0.1215686275, green: 0.7176470588, blue: 0.3764705882, alpha: 1)).original)
        
        let navMain = UINavigationController(rootViewController: mainVc)
        let navTop  = UINavigationController(rootViewController: topVc)
        let navFav  = UINavigationController(rootViewController: favVc)
        self.setViewControllers([navTop,navMain,navFav], animated: true)
    }
}
