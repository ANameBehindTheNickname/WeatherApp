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
                let networkError = error as! NetworkError
                var message = ""
                switch networkError {
                case .client:
                    message = "Make sure the city is spelled correctly and retry"
                case .noData:
                    message = "No weather for this city currently. Please retry later"
                case .server:
                    message = "Something broke on a weather provider side. Please retry later"
                case .undefined(let error):
                    message = "\(error.localizedDescription)"
                case .unknown:
                    message = "What happened is a mistery 😰. Probably its beacause \(error.localizedDescription). Please contact us"
                }
                
                DispatchQueue.main.async {
                    let errorVC = vcFactory.errorAlertVC(message)
                    vc.showDetailViewController(errorVC, sender: vc)
                }
            }
        }
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController.navigationBar.shadowImage = UIImage()
        
        let addCityAlert = vcFactory.cityAlertVC { [unowned self] city in
            vcViewModel.getWeather(for: city)
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
