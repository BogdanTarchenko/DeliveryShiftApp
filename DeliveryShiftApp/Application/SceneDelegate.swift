import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let firstVC = ViewController()
        firstVC.tabBarItem = UITabBarItem(title: "Расчёт", image: UIImage(named: "calculate.pdf"), tag: 0)
        
        let secondVC = SecondViewController()
        secondVC.tabBarItem = UITabBarItem(title: "История", image: UIImage(named: "time.pdf"), tag: 1)
        
        let thirdVC = ThirdViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "user.pdf"), tag: 2)
        
        let tabBarVC = UITabBarController()
        tabBarVC.setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        tabBarVC.selectedIndex = 0
        
        window.rootViewController = tabBarVC
        window.backgroundColor = .white
        
        secondVC.loadViewIfNeeded()
        thirdVC.loadViewIfNeeded()
        
        self.window = window
        window.makeKeyAndVisible()
    }
}


