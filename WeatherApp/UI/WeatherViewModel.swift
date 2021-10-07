//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

struct WeatherViewModel {
    let location: String
    var todayDate: String = ""
    let currentTemperature: String
    let minTemperature: String
    let maxTemperature: String
    
    init(location: String, currentTemperature: Double, minTemperature: Double, maxTemperature: Double) {
        self.location = location
        self.currentTemperature = "\(currentTemperature)"
        self.minTemperature = "\(minTemperature)"
        self.maxTemperature = "\(maxTemperature)"
        self.todayDate = stringFrom(Date())
    }
    
    private func stringFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        return dateFormatter.string(from: date)
    }
}
