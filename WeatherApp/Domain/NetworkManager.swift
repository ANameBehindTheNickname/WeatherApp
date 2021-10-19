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
    
    public func getData(from url: URL, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            completion(self.resultFrom(data, response, error))
        }
        
        task.resume()
    }
    
    private func resultFrom(_ data: Data?, _ response: URLResponse?, _ error: Error?)
    -> Result<Data, NetworkError> {
        if let error = error {
            return .failure(.undefined(error))
        } else if let response = response as? HTTPURLResponse,
           let networkError = response.networkError {
            return .failure(networkError)
        } else if data == nil {
            return .failure(.noData)
        } else if let data = data {
            return .success(data)
        }
        
        return .failure(.unknown)
    }
}

private extension HTTPURLResponse {
    var networkError: NetworkError? {
        switch statusCode {
        case (400...499): return .client
        case (500...599): return .server
        default: return nil
        }
    }
}

