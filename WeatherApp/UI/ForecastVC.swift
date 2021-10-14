//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class ForecastVC: UIViewController {    
    private let city: String
    private let forecastService: ForeCastService

    init(city: String, _ forecastService: ForeCastService) {
        self.city = city
        self.forecastService = forecastService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        forecastService.getForecast(for: city) { [weak self] result in
            switch result {
            case .success(let forecastVMs):
                DispatchQueue.main.async {
                    self?.forecastView.set(with: forecastVMs)
                }
            case .failure(let error):
                print("Couldn't get forecast viewModel - \(error.localizedDescription)")
            }
        }
    }
}
