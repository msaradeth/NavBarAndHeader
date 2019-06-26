//
//  Protocols.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void)
}
extension LoadImageService {
    func loadImage(imageUrl: String?, completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = imageUrl, let url = URL(string: imageUrl) else { return }
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                completion(image)
            }catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

