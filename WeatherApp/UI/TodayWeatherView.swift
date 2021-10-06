//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TodayWeatherView: UIView {
    @IBOutlet private(set) var contentView: UIView!
    @IBOutlet private(set) var locationLabel: UILabel!
    
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
    }
    
    private func commonInit() {
        let nibName = String(describing: TodayWeatherView.self)
        Bundle.main.loadNibNamed(nibName, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
