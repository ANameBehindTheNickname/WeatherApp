//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class OpenWeatherAPI: WeatherAPI {
    let networkProvider: NetworkProvider
    
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
    
    private func getCurrentWeather(from url: URL, completion: @escaping (Weather) -> Void) {
        let apiKey = "ENTER_YOUR_OPEN_WEATHER_API_KEY"
        let newURL = URL(string: url.absoluteString + "&appid=\(apiKey)")!
        networkProvider.getData(from: newURL) { result in
            switch result {
            case .success(let weatherData):
                guard let weatherResponse = try? JSONDecoder().decode(OpenWeatherResponse.self, from: weatherData) else {
                    print("Couldn't parse WeatherResponse from weatherData")
                    return
                }
                
                let weather = weatherResponse.weather[0]
                let main = weatherResponse.main
                completion(Weather(location: weatherResponse.name, iconId: weather.icon, description: weather.description, currentTemperature: main.temp, minTemperature: main.temp_min, maxTemperature: main.temp_max))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
