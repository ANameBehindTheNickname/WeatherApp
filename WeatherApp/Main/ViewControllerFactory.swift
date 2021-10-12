//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ViewControllerFactory {
    func todayWeatherVC() -> UIViewController {
        let session = URLSession(configuration: .default)
        let weatherAPI = OpenWeatherAPI(networkProvider: NetworkManager(session: session))
        let weatherService = WeatherAPItoServiceAdapter(weatherAPI)
        let locationProvider = GPSLocationAdapter(locationManager: .init())
        return TodayWeatherVC(weatherService, locationProvider)
    }
    
    func cityAlertVC() -> UIViewController {
        let alertController = UIAlertController(title: "Add city", message: "Enter city name", preferredStyle: .alert)
        let addCityAction = UIAlertAction(title: "Add city", style: .default)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        [addCityAction, cancelAction].forEach { alertController.addAction($0) }

        return alertController
    }
}
