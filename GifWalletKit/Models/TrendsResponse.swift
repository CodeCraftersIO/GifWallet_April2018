//
//  TrendsResponse.swift
//  GifWalletKit
//
//  Created by Jordi Serra i Font on 3/3/18.
//  Copyright © 2018 Pierluigi Cifani. All rights reserved.
//

import Foundation

public struct TrendsResponse: Decodable {
    public let data: [GIFResponse]
}

public struct GIFResponse {
    public let id: String
    public let username: String
    public let title: String
    public let importDateTime: Date
    public let images: GIFImagesListResponse
}

public struct GIFImagesListResponse: Decodable {
    public let downsized: GIFImageResponse
    public let original: GIFImageResponse
}

public struct GIFImageResponse {
    public let url: URL
    public let width: Float
    public let height: Float
}

extension GIFResponse: Decodable {
    
    private enum CodingKeys : String, CodingKey {
        case id, username, title, importDateTime = "import_datetime", images
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id: String = try container.decode(String.self, forKey: .id)
        let username: String = try container.decode(String.self, forKey: .username)
        let title: String = try container.decode(String.self, forKey: .title)
        let importDateTimeStr: String = try container.decode(String.self, forKey: .importDateTime)
        let images: GIFImagesListResponse = try container.decode(GIFImagesListResponse.self, forKey: .images)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        guard let date = dateFormatter.date(from: importDateTimeStr) else { throw GIFParsingErrors.invalidDateFormat }
        
        self.init(id: id, username: username, title: title, importDateTime: date, images: images)
    }
}


extension GIFImageResponse: Decodable {
    private enum CodingKeys : String, CodingKey {
        case url, width, height
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let urlStr: String = try container.decode(String.self, forKey: .url)
        let widthStr: String = try container.decode(String.self, forKey: .width)
        let heightStr: String = try container.decode(String.self, forKey: .height)
        
        guard let url = URL(string: urlStr) else { throw GIFParsingErrors.invalidURLConversion }
        
        guard let width = Float(widthStr),
            let height = Float(heightStr)
            else { throw GIFParsingErrors.invalidFloatConversion }
        
        self.init(url: url, width: width, height: height)
    }
}

private enum GIFParsingErrors: Error {
    case invalidDateFormat
    case invalidURLConversion
    case invalidFloatConversion
}
