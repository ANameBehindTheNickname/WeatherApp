//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class HourlyCell: UICollectionViewCell {
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var temperatureLabel: UILabel!
    
    func set(_ viewModel: ForecastViewModel.HourlyWeatherViewModel) {
        timeLabel.text = viewModel.time
        viewModel.getImageData { [weak self] data in
            DispatchQueue.main.async {
                self?.iconImageView.image = UIImage(data: data)
            }
        }
        
        temperatureLabel.text = viewModel.temperature
    }
}
