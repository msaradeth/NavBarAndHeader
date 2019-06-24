//
//  EventService.swift
//  NavBarAndHeader
//
//  Created by Mike Saradeth on 6/24/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import Foundation

struct EventService {
    let urlString = "https://raw.githubusercontent.com/phunware-services/dev-interview-homework/master/feed.json"
    
    func loadData(completion: @escaping ([EventModel]) -> Void) {
        loadDataFromServer(completion: completion)        
    }
    
    func loadDataFromServer(completion: @escaping ([EventModel]) -> Void) {
        HttpHelp.request(urlString, method: .get, success: { (dataResponse) in
            guard let data = dataResponse.data else { return }
            do {
                let decoder = JSONDecoder()
                var events = try decoder.decode(Array<EventModel>.self, from: data)
                events = events.filter{ $0.imageUrl != nil }
                completion(events)
            }catch let error {
                print(error.localizedDescription)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func loadDataFromDisk(completion: @escaping ([EventModel]) -> Void) {
        
    }
}
