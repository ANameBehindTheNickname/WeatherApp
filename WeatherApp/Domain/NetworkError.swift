//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case client
    case server
    case noData
    case undefined(Error)
    case unknown
}
