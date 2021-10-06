//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

final class NetworkManager: NetworkProvider {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    public func getData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            data.map { completion(.success($0)) }
            error.map { completion(.failure($0)) }
        }
        
        task.resume()
    }
}

