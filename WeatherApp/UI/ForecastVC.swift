//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ForecastVC: UIViewController {
    
    private let viewModels: [ForecastViewModel] = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"].map {
        let randomInt = Int.random(in: 0...12)
        let randomDouble = Double.random(in: 15...30)
        return .init(day: $0, hourlyWeatherViewModels: [.init(time: "\(randomInt)", temperature: "\(randomDouble)"),
                                                        .init(time: "\(randomInt)", temperature: "\(randomDouble)"),
                                                        .init(time: "\(randomInt)", temperature: "\(randomDouble)"),
                                                        .init(time: "\(randomInt)", temperature: "\(randomDouble)"),
                                                        .init(time: "\(randomInt)", temperature: "\(randomDouble)"),
                                                        .init(time: "\(randomInt)", temperature: "\(randomDouble)")])
    }
    
    var forecastView: ForecastView {
        view as! ForecastView
    }
    
    override func loadView() {
        super.loadView()
        view = ForecastView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        forecastView.set(with: viewModels)
    }
}
