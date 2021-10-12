//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class BarButtonController: NSObject {
    private let addCityButton = UIBarButtonItem(image: .init(systemName: "plus.circle"), style: .done, target: nil, action: nil)
    private let forecastButton = UIBarButtonItem(image: .init(systemName: "thermometer"), style: .done, target: nil, action: nil)
    
    var barButtons: [UIBarButtonItem] {
        [addCityButton, forecastButton]
    }
    
    var addCityCallback: (() -> Void)? {
        didSet {
            addCityButton.target = self
            addCityButton.action = #selector(fireAddCityCallback)
        }
    }
    
    var forecastCallback: (() -> Void)? {
        didSet {
            forecastButton.target = self
            forecastButton.action = #selector(fireForecastCallback)
        }
    }
    
    @objc private func fireAddCityCallback() {
        addCityCallback?()
    }
    
    @objc private func fireForecastCallback() {
        forecastCallback?()
    }
}
