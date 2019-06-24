//
//  MasterViewModel.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation
import UIKit

protocol MasterViewModelDelegagte {
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void)  
}

class MasterViewModel {
    fileprivate var eventService: EventService
    var items: [EventModel]
    var count: Int {
        return items.count
    }
    subscript(indexPath: IndexPath) -> EventModel {
        return items[indexPath.row]
    }
    init(items: [EventModel], eventService: EventService) {
        self.items = items
        self.eventService = eventService
    }
    
    func loadData(completion: @escaping ()->Void) {
        eventService.loadDataFromServer { [weak self] (events) in
            self?.items = events
            completion()
        }
    }
}

extension MasterViewModel: MasterViewModelDelegagte, LoadImageService {
    func loadImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        loadImage(imageUrl: items[index].imageUrl) { [weak self] (image) in
            self?.items[index].imageCache = image
            completion(image)
        }
    }
}
