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
        
        let session = URLSession(configuration: .default)
        let weatherAPI = OpenWeatherAPI(networkProvider: NetworkManager(session: session))
        let weatherService = WeatherAPItoServiceAdapter(weatherAPI)
        
        let vc = vcFactory.todayWeatherVC(weatherService)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        let addCityAlert = vcFactory.cityAlertVC { city in
            weatherService.getTodayWeather(for: city, completion: vc.getWeatherCompletion)
        }
        
        buttonController.addCityCallback = {
            vc.showDetailViewController(addCityAlert, sender: vc)
        }
        
        buttonController.forecastCallback = {
            vc.show(vcFactory.forecastVC(), sender: vc)
        }
        
        vc.navigationItem.rightBarButtonItems = buttonController.barButtons
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
