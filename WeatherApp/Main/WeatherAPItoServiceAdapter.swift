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
    
    func getTodayWeather(for city: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        weatherAPI.getCurrentWeather(for: city) { [weak self] weather in
            self?.weatherAPICompletion(weather, completion: completion)
        }
    }
    
    func getTodayWeather(lat: String, lon: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        weatherAPI.getCurrentWeather(lat: lat, lon: lon) { [weak self] weather in
            self?.weatherAPICompletion(weather, completion: completion)
        }
    }
    
    private func weatherAPICompletion(_ weather: Weather, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        let viewModel = WeatherViewModel(location: weather.location,
                                         currentTemperature: weather.currentTemperature,
                                         description: weather.description,
                                         minTemperature: weather.minTemperature,
                                         maxTemperature: weather.maxTemperature
        )

        weatherAPI.getWeatherIconData(iconId: weather.iconId) { iconData in
            viewModel.weatherIconData = iconData
        }

        completion(.success(viewModel))
    }
}
