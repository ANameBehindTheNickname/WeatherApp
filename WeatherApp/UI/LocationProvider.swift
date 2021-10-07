//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

protocol LocationProvider {
    var city: String? { get }
    var lat: String { get }
    var lon: String { get }
}
