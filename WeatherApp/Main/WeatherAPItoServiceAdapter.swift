//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class WeatherAPItoServiceAdapter: WeatherService {
    private let weatherAPI: WeatherAPI
    
    init(weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func getTodayWeather(completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        weatherAPI.getCurrentWeather { [weak self] weather in
            let viewModel = WeatherViewModel(location: weather.location,
                                             currentTemperature: weather.currentTemperature,
                                             description: weather.description,
                                             minTemperature: weather.minTemperature,
                                             maxTemperature: weather.maxTemperature
            )
            
            self?.weatherAPI.getWeatherIconData(iconId: weather.iconId) { iconData in
                viewModel.weatherIconData = iconData
            }
            
            completion(.success(viewModel))
        }
    }
}
