//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ViewControllerFactory {
    func todayWeatherVC(_ viewModel: TodayWeatherVCViewModel) -> TodayWeatherVC {
        TodayWeatherVC(viewModel)
    }
    
    func forecastVC(for city: String, _ forecastService: ForeCastService) -> UIViewController {
        ForecastVC(city: city, forecastService)
    }
    
    func cityAlertVC(_ addCityCompletion: @escaping (String) -> Void) -> UIViewController {
        let alertController = UIAlertController(title: "Add city", message: "", preferredStyle: .alert)
        alertController.addTextField {
            $0.placeholder = "CityName"
        }
        
        let addCityAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let firstTextField = alertController.textFields?.first,
                  let cityName = firstTextField.text else { return }
            
            addCityCompletion(cityName)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        [addCityAction, cancelAction].forEach { alertController.addAction($0) }
        return alertController
    }
    
    func errorAlertVC(_ message: String) -> UIViewController {
        let alertController = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        
        return alertController
    }
}
