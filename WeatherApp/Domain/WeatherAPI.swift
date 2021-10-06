//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol WeatherAPI {
    var networkProvider: NetworkProvider { get }
    func getCurrentWeather(completion: @escaping (Weather) -> Void)
}
