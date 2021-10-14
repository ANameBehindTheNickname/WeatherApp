//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol WeatherService {
    func getTodayWeather(for city: String, completion: @escaping (Result<WeatherViewModel, Error>) -> Void)
    func getTodayWeather(lat: Double, lon: Double, completion: @escaping (Result<WeatherViewModel, Error>) -> Void)
}

protocol ForeCastService {
    func getForecast(for city: String, completion: @escaping (Result<[ForecastViewModel], Error>) -> Void)
}
