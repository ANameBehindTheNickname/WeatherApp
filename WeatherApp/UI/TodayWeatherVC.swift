//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TodayWeatherVC: UIViewController {
    var weatherView: TodayWeatherView {
        view as! TodayWeatherView
    }
    
    private var weatherService: WeatherService
    private var locationProvider: LocationProvider
    
    init(weatherService: WeatherService, locationProvider: LocationProvider) {
        self.weatherService = weatherService
        self.locationProvider = locationProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = TodayWeatherView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationProvider.startProvidingLocation { [weak self] lat, lon in
            guard let self = self else { return }
            self.weatherService.getTodayWeather(lat: lat, lon: lon, completion: self.getWeatherCompletion)
        }
    }
    
    func getWeatherCompletion(_ result: Result<WeatherViewModel, Error>) -> Void {
        switch result {
        case .success(let viewModel):
            DispatchQueue.main.async {
                self.weatherView.set(viewModel)
            }
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
}
