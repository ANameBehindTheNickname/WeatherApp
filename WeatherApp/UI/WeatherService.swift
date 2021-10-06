//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol WeatherService {
    func getTodayWeather(completion: @escaping (Result<WeatherViewModel, Error>) -> Void)
}
