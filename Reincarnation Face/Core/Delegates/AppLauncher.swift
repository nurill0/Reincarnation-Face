import Foundation
import UIKit


final class AppLauncher{
    
    var userDefaults = UserDefaultsManager.shared
    
    private(set) var window: UIWindow
    
    @available(iOS 13.0, *)
    init(windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        setup()
        
    }
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
        setup()
        
    }
    
    fileprivate func setup() {
        configureInitials()
    }
    
    fileprivate func configureInitials(){
        
    }
    
    func showMainPage() {
        var navCtrl = createNavCtrl(rootVC: UIViewController())
        if userDefaults.getNickName().isEmpty == false && userDefaults.getNickName() != "unknown" {
            navCtrl = createNavCtrl(rootVC: MenuVC())
        }else{
            navCtrl = createNavCtrl(rootVC: BeginVC())
        }
        window.rootViewController = navCtrl
        window.makeKeyAndVisible()
    }
}
