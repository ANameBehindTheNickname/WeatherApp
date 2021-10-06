//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let session = URLSession(configuration: .default)
        let weatherAPI = OpenWeatherAPI(networkProvider: NetworkManager(session: session))
        let weatherService = WeatherAPItoServiceAdapter(weatherAPI: weatherAPI)
        let vc = TodayWeatherVC(weatherService: weatherService)
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        self.window = window
    }
}


//final class TestWeatherService: WeatherService {
//    func getTodayWeather(completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
//
//    }
//}
