//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

protocol WeatherAPI {
    var networkProvider: NetworkProvider { get }
    func getCurrentWeather(for city: String, completion: @escaping (Result<Weather, NetworkError>) -> Void)
    func getCurrentWeather(lat: Double, lon: Double, completion: @escaping (Result<Weather, NetworkError>) -> Void)
    func getWeatherIconData(iconId: String, completion: @escaping (Data) -> Void)
    func forecast(for city: String, completion: @escaping ([Weather]) -> Void)
}
