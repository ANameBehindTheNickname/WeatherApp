//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

struct OpenWeatherResponse: Decodable {
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let weather: [Weather]
    let main: Main
    let name: String
}

final class OpenWeatherAPI: WeatherAPI {
    let networkProvider: NetworkProvider
    
    init(networkProvider: NetworkProvider) {
        self.networkProvider = networkProvider
    }
    
    func getCurrentWeather(completion: @escaping (Weather) -> Void) {
        let apiKey = "ENTER_YOUR_OPEN_WEATHER_API_KEY"
        let city = "ENTER_CITY"
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(apiKey)")!
        networkProvider.getData(from: url) { result in
            switch result {
            case .success(let weatherData):
                guard let weatherResponse = try? JSONDecoder().decode(OpenWeatherResponse.self, from: weatherData) else {
                    print("Couldn't parse WeatherResponse from weatherData")
                    return
                }
                
                let weather = weatherResponse.weather[0]
                let main = weatherResponse.main
                completion(Weather(location: weatherResponse.name, description: weather.description, currentTemperature: main.temp, minTemperature: main.temp_min, maxTemperature: main.temp_max))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
