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
        
        let session = URLSession(configuration: .default)
        let weatherAPI = OpenWeatherAPI(networkProvider: NetworkManager(session: session))
        let weatherService = WeatherAPItoServiceAdapter(weatherAPI: weatherAPI)
        let locationProvider = GPSLocationAdapter(locationManager: .init())
        let vc = TodayWeatherVC(weatherService: weatherService, locationProvider: locationProvider)
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        buttonController.addCityCallback = { [weak self] in
            guard let self = self else { return }
            vc.showDetailViewController(self.makeAddCityAlert(), sender: vc)
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
    
    private func makeAddCityAlert() -> UIViewController {
        let alertController = UIAlertController(title: "Add city", message: "Enter city name", preferredStyle: .alert)
        let addCityAction = UIAlertAction(title: "Add city", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        [addCityAction, cancelAction].forEach { alertController.addAction($0) }

        return alertController
    }
}

private final class BarButtonController: NSObject {
    private let addCityButton = UIBarButtonItem(image: .init(systemName: "plus.circle"), style: .done, target: nil, action: nil)
    private let forecastButton = UIBarButtonItem(image: .init(systemName: "thermometer"), style: .done, target: nil, action: nil)
    
    var barButtons: [UIBarButtonItem] {
        [addCityButton, forecastButton]
    }
    
    var addCityCallback: (() -> Void)? {
        didSet {
            addCityButton.target = self
            addCityButton.action = #selector(fireAddCityCallback)
        }
    }
    
    var forecastCallback: (() -> Void)? {
        didSet {
            forecastButton.target = self
            forecastButton.action = #selector(fireForecastCallback)
        }
    }
    
    @objc private func fireAddCityCallback() {
        addCityCallback?()
    }
    
    @objc private func fireForecastCallback() {
        forecastCallback?()
    }
}
