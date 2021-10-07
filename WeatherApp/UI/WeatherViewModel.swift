//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class WeatherViewModel {
    let location: String
    var todayDate: String = ""
    let currentTemperature: String
    var weatherIconData: Data? {
        didSet {
            guard let data = weatherIconData else { return }
            getImageDataCompletion?(data)
        }
    }
    let description: String
    let minTemperature: String
    let maxTemperature: String
    
    private var getImageDataCompletion: ((Data) -> Void)?
    
    init(location: String, currentTemperature: Double, description: String, minTemperature: Double, maxTemperature: Double) {
        self.location = location
        self.currentTemperature = "\(currentTemperature)"
        self.description = description
        self.minTemperature = "\(minTemperature)"
        self.maxTemperature = "\(maxTemperature)"
        self.todayDate = stringFrom(Date())
    }
    
    func getImageData(completion: @escaping (Data) -> Void) {
        guard let data = weatherIconData else {
            getImageDataCompletion = completion
            return
        }
        
        completion(data)
    }
    
    private func stringFrom(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM y"
        return dateFormatter.string(from: date)
    }
}
