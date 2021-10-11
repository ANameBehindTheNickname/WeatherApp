//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import CoreLocation

final class GPSLocationAdapter: NSObject {
    private let locationManager: CLLocationManager
    weak var delegate: LocationProviderDelegate?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
}

extension GPSLocationAdapter: LocationProvider {
    func startProvidingLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension GPSLocationAdapter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude

        delegate?.didUpdateLocation(lat: lat, lon: lon)
    }
}
