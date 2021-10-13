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
    }
    
    let day: String
    let hourlyWeatherViewModels: [HourlyWeatherViewModel]
}
