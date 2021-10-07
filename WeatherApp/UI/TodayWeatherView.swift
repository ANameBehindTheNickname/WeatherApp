//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TodayWeatherView: UIView {
    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private(set) var locationLabel: UILabel!
    @IBOutlet private(set) var dateLabel: UILabel!
    @IBOutlet private(set) var currentTempLabel: UILabel!
    @IBOutlet private(set) var minTempLabel: UILabel!
    @IBOutlet private(set) var maxTempLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func set(_ viewModel: WeatherViewModel) {
        locationLabel.text = viewModel.location
        dateLabel.text = viewModel.todayDate
        currentTempLabel.text = viewModel.currentTemperature
        minTempLabel.text = viewModel.minTemperature
        maxTempLabel.text = viewModel.maxTemperature
    }
    
    private func commonInit() {
        let nibName = String(describing: TodayWeatherView.self)
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
