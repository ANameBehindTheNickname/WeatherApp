//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import CoreLocation

final class GPSLocationAdapter: NSObject {
    private let locationManager: CLLocationManager
    private var locationFoundCompletion: ((_ lat: Double, _ lon: Double) -> Void)?
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
}

extension GPSLocationAdapter: LocationProvider {
    func startProvidingLocation(completion: @escaping (_ lat: Double, _ lon: Double) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationFoundCompletion = completion
    }
}

extension GPSLocationAdapter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        locationFoundCompletion?(lat, lon)
    }
}
