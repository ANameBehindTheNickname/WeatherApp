//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import XCTest
@testable import WeatherApp

final class TodayWeatherVCTests: XCTestCase {

    func test_getWeatherCompletion_success_rendersTodayWeatherView() {
        let viewModel = WeatherViewModel(location: "location", currentTemperature: 22, minTemperature: 18, maxTemperature: 37)
        let weatherService = WeatherServiceStub(viewModel: viewModel)
        let sut = TodayWeatherVC(weatherService: weatherService)
        
        sut.getWeatherCompletion(.success(viewModel))
        
        XCTAssertEqual(sut.weatherView.locationLabel.text, viewModel.location)
        XCTAssertEqual(sut.weatherView.dateLabel.text, viewModel.todayDate)
        XCTAssertEqual(sut.weatherView.currentTempLabel.text, "\(viewModel.currentTemperature)")
        XCTAssertEqual(sut.weatherView.minTempLabel.text, "\(viewModel.minTemperature)")
        XCTAssertEqual(sut.weatherView.maxTempLabel.text, "\(viewModel.maxTemperature)")
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
