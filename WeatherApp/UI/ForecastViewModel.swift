//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

struct ForecastViewModel {
    struct HourlyWeatherViewModel {
        let time: String
        let weatherIcon = UIImage(named: "icon")
        let temperature: String
        
        init(time: String, temperature: Double) {
            self.time = time
            self.temperature = "\(temperature)"
        }
    }
    
    let day: String
    let hourlyWeatherViewModels: [HourlyWeatherViewModel]
    
    init(day: String, hourlyWeatherViewModels: [HourlyWeatherViewModel]) {
        self.day = Self.weekdayString(from: day) ?? ""
        self.hourlyWeatherViewModels = hourlyWeatherViewModels
    }
    
    private static func weekdayString(from dateString: String) -> String? {
        let format = "yyyy-MM-dd"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        
        dateFormatter.dateFormat = "EEEE"
        let weekday = dateFormatter.string(from: date)
        
        return weekday
    }
}
