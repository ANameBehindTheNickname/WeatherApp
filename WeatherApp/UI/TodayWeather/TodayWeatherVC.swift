//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import UIKit

final class TodayWeatherVC: UIViewController {
    var weatherView: TodayWeatherView {
        view as! TodayWeatherView
    }
    
    private let viewModel: TodayWeatherVCViewModel
    
    init(_ viewModel: TodayWeatherVCViewModel) {
        self.viewModel = viewModel
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
        viewModel.getWeatherForCurrentLocation()
    }
}
