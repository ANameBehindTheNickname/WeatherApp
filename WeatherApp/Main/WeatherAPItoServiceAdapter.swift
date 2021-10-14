//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class WeatherAPItoServiceAdapter: WeatherService {
    let weatherAPI: WeatherAPI
    
    init(_ weatherAPI: WeatherAPI) {
        self.weatherAPI = weatherAPI
    }
    
    func getTodayWeather(for city: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        weatherAPI.getCurrentWeather(for: city) { [weak self] weather in
            self?.weatherAPICompletion(weather, completion: completion)
        }
    }
    
    func getTodayWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
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

extension WeatherAPItoServiceAdapter: ForeCastService {
    struct Forecast {
        let day: String
        let time: String
        let temperature: Double
    }
    
    func getForecast(for city: String, completion: @escaping (Result<[ForecastViewModel], Error>) -> Void) {
        weatherAPI.forecast(for: city) { weathers in
            let forecastWeathers: [Forecast] = weathers.map {
                let day = String($0.timestamp?.prefix(while: { $0 != " "}) ?? "")
                let time = String($0.timestamp?.drop(while: { $0 != " " }) ?? "")
                return .init(day: day, time: time, temperature: $0.currentTemperature)
            }

            let viewModels = forecastWeathers.reduce([ForecastViewModel]()) { acc, forecast in
                let stubVM = ForecastViewModel(day: forecast.day, hourlyWeatherViewModels: [])
                if acc.last?.day == stubVM.day {
                    var lastHourlyWeathertVMs = acc.last?.hourlyWeatherViewModels
                    lastHourlyWeathertVMs?.append(.init(time: forecast.time, temperature: forecast.temperature))
                    
                    return acc.dropLast() + [.init(day: forecast.day, hourlyWeatherViewModels: lastHourlyWeathertVMs ?? [])]
                }
                
                return acc + [.init(day: forecast.day,
                                    hourlyWeatherViewModels: [.init(time: forecast.time, temperature: forecast.temperature)])]
            }
            
            completion(.success(viewModels))
        }
    }
}
