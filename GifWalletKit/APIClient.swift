//
//  Created by Pierluigi Cifani on 02/03/2018.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

final public class APIClient {
    
    public static let shared = APIClient()
    
    private init() {}
    
    private var cache: [String: Any] = [:]
    
    private enum CacheTypes: String {
        case trends
    }
    
    public func fetchTrends(completion: @escaping (TrendsResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) { [weak self] in
            guard let `self` = self else { return }
            guard let fileURL = Bundle.main.url(forResource: "trends", withExtension: "json"),
                let data = try? Data(contentsOf: fileURL),
                let response = try? JSONDecoder().decode(TrendsResponse.self, from: data)
                else {
                    fatalError("Could not find trends.json file")
            }
            completion(response)
            
            //Store the response
            self.cache[CacheTypes.trends.rawValue] = response
        }
    }
    
    public func retrieveGIF(withId id: String, completion: @escaping (GIFResponse) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            guard let `self` = self else { return }
            guard let trends = self.cache[CacheTypes.trends.rawValue] as? TrendsResponse else {
                fatalError("There shouldn't be anything but trends response in this cache part")
            }
            guard let wantedGif = trends.data.filter({ $0.id == id }).first else {
                fatalError("There's no gif with that id in cache")
            }
            completion(wantedGif)
        }
    }
}
