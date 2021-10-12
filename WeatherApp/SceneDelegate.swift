//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    private let buttonController = BarButtonController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let vcFactory = ViewControllerFactory()
        let vc = vcFactory.todayWeatherVC()
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        buttonController.addCityCallback = {
            vc.showDetailViewController(vcFactory.cityAlertVC(), sender: vc)
        }
        
        buttonController.forecastCallback = {
            print("TODO: - not implemented, show ForecastVC")
        }
        
        vc.navigationItem.rightBarButtonItems = buttonController.barButtons
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
