//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

protocol WeatherAPI {
    var networkProvider: NetworkProvider { get }
    func getCurrentWeather(for city: String, completion: @escaping (Weather) -> Void)
    func getCurrentWeather(lat: String, lon: String, completion: @escaping (Weather) -> Void)
    func getWeatherIconData(iconId: String, completion: @escaping (Data) -> Void)
}
