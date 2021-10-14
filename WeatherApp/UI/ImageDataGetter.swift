//
//
//  Copyright © 2021 ANameBehindTheNickname. All rights reserved.
//

import Foundation

class ImageDataGetter {
    var imageData: Data? {
        didSet {
            guard let data = imageData else { return }
            getImageDataCompletion?(data)
        }
    }
    
    private var getImageDataCompletion: ((Data) -> Void)?
    
    func getImageData(completion: @escaping (Data) -> Void) {
        guard let data = imageData else {
            getImageDataCompletion = completion
            return
        }
        
        completion(data)
    }
}
