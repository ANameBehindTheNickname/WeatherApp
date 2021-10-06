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
        weatherAPI.getCurrentWeather { weather in
            completion(.success(.init(location: weather.location, currentTemperature: weather.currentTemperature, minTemperature: weather.minTemperature, maxTemperature: weather.maxTemperature)))
        }
    }
}
