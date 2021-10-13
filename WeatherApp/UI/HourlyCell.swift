//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class HourlyCell: UICollectionViewCell {
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var weatherIcon: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    
    func set(_ viewModel: ForecastViewModel.HourlyWeatherViewModel) {
        timeLabel.text = viewModel.time
        weatherIcon.image = viewModel.weatherIcon
        temperatureLabel.text = viewModel.temperature
    }
}
