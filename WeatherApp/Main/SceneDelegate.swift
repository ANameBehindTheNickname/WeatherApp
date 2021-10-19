//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    private let buttonController = BarButtonController()
    
    private lazy var session = URLSession(configuration: .default)
    private lazy var weatherAPI = OpenWeatherAPI(networkProvider: NetworkManager(session: session))
    private lazy var weatherService = WeatherAPItoServiceAdapter(weatherAPI)
    private lazy var locationProvider = GPSLocationAdapter(locationManager: .init())
    
    private lazy var vcViewModel = TodayWeatherVCViewModel(weatherService, locationProvider)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let vcFactory = ViewControllerFactory()
        
        let vc = vcFactory.todayWeatherVC(vcViewModel)
        vcViewModel.getWeatherCompletion = { result in
            switch result {
            case .success(let weatherViewModel):
                DispatchQueue.main.async {
                    vc.weatherView.set(weatherViewModel)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    print(error)
                }
            }
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        let addCityAlert = vcFactory.cityAlertVC { [unowned self] city in
            weatherService.getTodayWeather(for: city) {
                vcViewModel.getWeatherCompletion?($0)
            }
        }
        
        buttonController.addCityCallback = {
            vc.showDetailViewController(addCityAlert, sender: vc)
        }
        
        buttonController.forecastCallback = { [unowned self] in
            let forecastVC = vcFactory.forecastVC(for: vcViewModel.city, weatherService)
            forecastVC.title = "Forecast"
            vc.show(forecastVC, sender: vc)
        }
        
        vc.navigationItem.rightBarButtonItems = buttonController.barButtons
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        self.window = window
    }
}
