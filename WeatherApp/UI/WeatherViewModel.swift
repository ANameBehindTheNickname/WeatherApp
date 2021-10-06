//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct WeatherViewModel {
    let location: String
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    
    init(location: String, currentTemperature: Double, minTemperature: Double, maxTemperature: Double) {
        self.location = location
        self.currentTemperature = "\(currentTemperature)"
        self.minTemperature = "\(minTemperature)"
        self.maxTemperature = "\(maxTemperature)"
    }
}
