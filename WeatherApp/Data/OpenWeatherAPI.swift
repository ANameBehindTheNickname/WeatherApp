//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class OpenWeatherAPI: WeatherAPI {
    let networkProvider: NetworkProvider
    private let apiKey = "ENTER_YOUR_OPEN_WEATHER_API_KEY"
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func getCurrentWeather(for city: String, completion: @escaping (Weather) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric")!
        getCurrentWeather(from: url, completion: completion)
    }
    
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Weather) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&units=metric")!
        getCurrentWeather(from: url, completion: completion)
    }
    
    func getWeatherIconData(iconId: String, completion: @escaping (Data) -> Void) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(iconId)@2x.png")!
        self.networkProvider.getData(from: url) { result in
            switch result {
            case .success(let iconData):
                completion(iconData)
            case .failure(let error):
                print("Couldn't get image data - \(error.localizedDescription)")
            }
        }
    }
    
    func forecast(for city: String, completion: @escaping ([Weather]) -> Void) {
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&units=metric&appid=\(apiKey)")!
        networkProvider.getData(from: url) { result in
            switch result {
            case .success(let weatherData):
                guard let forecastResponse = try? JSONDecoder().decode(ForecastResponse.self, from: weatherData) else {
                    print("Couldn't parse WeatherResponse from weatherData - forecast")
                    return
                }
                
                let weatherResponses = forecastResponse.list
                let weather: [Weather] = weatherResponses.map {
                    let weather = $0.weather[0]
                    let main = $0.main
                    return .init(location: "", iconId: weather.icon, description: weather.description, currentTemperature: main.temp, minTemperature: 0, maxTemperature: 0, timestamp: $0.dt_txt)
                }
                
                completion(weather)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getCurrentWeather(from url: URL, completion: @escaping (Weather) -> Void) {
        let newURL = URL(string: url.absoluteString + "&appid=\(apiKey)")!
        networkProvider.getData(from: newURL) { result in
            switch result {
            case .success(let weatherData):
                guard let weatherResponse = try? JSONDecoder().decode(OpenWeatherResponse.self, from: weatherData) else {
                    print("Couldn't parse WeatherResponse from weatherData; current weather")
                    return
                }
                
                let weather = weatherResponse.weather[0]
                let main = weatherResponse.main
                
                guard let location = weatherResponse.name else { return }
                completion(Weather(location: location, iconId: weather.icon, description: weather.description, currentTemperature: main.temp, minTemperature: main.temp_min, maxTemperature: main.temp_max))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
