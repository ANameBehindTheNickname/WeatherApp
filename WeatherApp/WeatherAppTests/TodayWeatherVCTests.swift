//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import XCTest
@testable import WeatherApp

final class TodayWeatherVCTests: XCTestCase {

    func test_getWeatherCompletion_success_rendersTodayWeatherView() {
        let viewModel = WeatherViewModel(location: "Location")
        let weatherService = WeatherServiceStub(viewModel: viewModel)
        let sut = TodayWeatherVC(weatherService: weatherService)
        
        sut.getWeatherCompletion(.success(viewModel))
        
        XCTAssertEqual(sut.weatherView.locationLabel.text, viewModel.location)
    }
}

final class WeatherServiceStub: WeatherService {
    private let viewModel: WeatherViewModel
    
    init(viewModel: WeatherViewModel) {
        self.viewModel = viewModel
    }
    
    func getTodayWeather(completion: @escaping (Result<WeatherViewModel, Error>) -> Void) {
        
    }
}
