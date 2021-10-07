//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol WeatherService {
    func getTodayWeather(for city: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void)
    func getTodayWeather(lat: String, lon: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void)
}
