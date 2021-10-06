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
    
    func getCurrentWeather(completion: @escaping (Weather) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(Weather(location: "Test Location", currentTemperature: 23.5, minTemperature: 19, maxTemperature: 28))
        }
    }
}
