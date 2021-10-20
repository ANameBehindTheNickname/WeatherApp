//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class TodayWeatherVCViewModel {
    var city = ""
    var getWeatherCompletion: ((Result<WeatherViewModel, Error>) -> Void)?
    private var weatherService: WeatherService
    private var locationProvider: LocationProvider
    
    init(_ weatherService: WeatherService, _ locationProvider: LocationProvider) {
        self.weatherService = weatherService
        self.locationProvider = locationProvider
    }
    
    func getWeather() {
        locationProvider.startProvidingLocation { [unowned self] lat, lon in
            weatherService.getTodayWeather(lat: lat, lon: lon) {
                if let location = try? $0.get().location {
                    city = location
                }
                
                getWeatherCompletion?($0)
            }
        }
    }
}
