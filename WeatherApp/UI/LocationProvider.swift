//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol LocationProvider {
    func startProvidingLocation(completion: @escaping (_ lat: Double, _ lon: Double) -> Void)
    func stopProvidingLocation()
}
