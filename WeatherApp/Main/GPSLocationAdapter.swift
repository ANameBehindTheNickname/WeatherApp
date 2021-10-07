//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class GPSLocationAdapter: LocationProvider {
    var city: String?
    let lat: String
    let lon: String
    
    init(gpsLocation: GPSLocation) {
        city = nil
        self.lat = gpsLocation.lat
        self.lon = gpsLocation.lon
    }
}

