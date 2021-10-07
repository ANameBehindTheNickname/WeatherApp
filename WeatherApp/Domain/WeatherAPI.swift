//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

protocol WeatherAPI {
    var networkProvider: NetworkProvider { get }
    func getCurrentWeather(completion: @escaping (Weather) -> Void)
    func getWeatherIconData(iconId: String, completion: @escaping (Data) -> Void)
}
