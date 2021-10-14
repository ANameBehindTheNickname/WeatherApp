//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class WeatherViewModel: ImageDataGetter {
    let location: String
    var todayDate: String = ""
    let currentTemperature: String
    let description: String
    let minTemperature: String
    let maxTemperature: String
    
    init(location: String, currentTemperature: Double, description: String, minTemperature: Double, maxTemperature: Double) {
        self.location = location
        self.currentTemperature = "\(currentTemperature) °C"
        self.description = description
        self.minTemperature = "\(minTemperature) °C"
        self.maxTemperature = "\(maxTemperature) °C"
        super.init()
        self.todayDate = stringFrom(Date())
    }
    
    private func stringFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        return dateFormatter.string(from: date)
    }
}
