//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

protocol NetworkProvider {
    func getData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void)
}
