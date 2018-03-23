//
//  Created by Pierluigi Cifani on 23/03/2018.
//  Copyright © 2018 Code Crafters. All rights reserved.
//

import Foundation

public class GiphyAPIClient: APIClient {
    public init() {
        let signature = APIClient.Signature(name: "api_key", value: "kw7ABCKe5AfWxPu0qLcjaN7MpQdqAPES")
        super.init(environment: Giphy.Hosts.production, signature: signature)
    }

    public func fetchTrending(handler: @escaping (Giphy.Responses.Page?, Swift.Error?) -> Void) {
        let request = Request<Giphy.Responses.Page>(
            endpoint: Giphy.API.trending
        )
        self.perform(request) { (response, error) in
            handler(response, error)
        }
    }

    public func searchGif(term: String, handler: @escaping (Giphy.Responses.Page?, Swift.Error?) -> Void) {
        let request = Request<Giphy.Responses.Page>(
            endpoint: Giphy.API.search(term)
        )
        self.perform(request) { (response, error) in
            handler(response, error)
        }
    }
}

public enum Giphy {
    enum Hosts: Environment {
        case production

        var baseURL: URL {
            switch self {
            case .production:
                return URL(string: "https://api.giphy.com")!
            }
        }
    }

    enum API: Endpoint {
        case trending
        case search(String)

        var path: String {
            switch self {
            case .trending:
                return "/v1/gifs/trending"
            case .search(let term):
                return "/v1/gifs/search?q=\(term)"
            }
        }
    }

    public enum Responses {
        public struct GIF: Decodable {
            let id: String
            let url: URL

            private enum GIFKeys: String, CodingKey {
                case id = "id"
                case images = "images"
            }

            private enum ImagesKeys: String, CodingKey {
                case original = "original"
            }

            private enum ImageKeys: String, CodingKey {
                case url = "url"
            }

            init(id: String, url: URL) {
                self.id = id
                self.url = url
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: GIFKeys.self)
                let id: String = try container.decode(String.self, forKey: .id)
                let imagesContainer = try container.nestedContainer(keyedBy: ImagesKeys.self, forKey: .images)
                let originalContainer = try imagesContainer.nestedContainer(keyedBy: ImageKeys.self, forKey: .original)
                let url: URL = try originalContainer.decode(URL.self, forKey: .url)
                self.init(id: id, url: url)
            }
        }

        public struct Page: Decodable {
            let data: [GIF]
        }
    }
}
