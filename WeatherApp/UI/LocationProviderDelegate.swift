//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol LocationProviderDelegate: AnyObject {
    func didUpdateLocation(lat: Double, lon: Double)
}
