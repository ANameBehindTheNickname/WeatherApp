//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

struct OpenWeatherResponse: Decodable {
    struct Weather: Decodable {
        let description: String
        let icon: String
    }
    
    struct Main: Decodable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let weather: [Weather]
    let main: Main
    let name: String?
    let dt_txt: String?
}
