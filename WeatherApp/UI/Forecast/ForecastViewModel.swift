//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

struct ForecastViewModel {
    final class HourlyWeatherViewModel: ImageDataGetter {
        let time: String
        let temperature: String
        
        init(time: String, temperature: Double) {
            self.time = String(time.prefix(6))
            self.temperature = "\(temperature) °C"
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
