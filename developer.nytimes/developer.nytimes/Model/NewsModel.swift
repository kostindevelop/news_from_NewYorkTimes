//
//  NewsModel.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 10.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//
//   let newsModel = try? JSONDecoder().decode(NewsModel.self, from: jsonData)

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let status: String?
    let copyright: String?
    let numResults: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case copyright = "copyright"
        case numResults = "num_results"
        case results = "results"
    }
}

// MARK: - Result
struct Result: Codable {
    let url: String?
    let adxKeywords: String?
    let subsection: String?
    let emailCount: Int?
    let countType: String?
    let column: String?
    let etaId: Int?
    let section: String?
    let id: Int?
    let assetId: Int?
    let nytdsection: String?
    let byline: String?
    let type: String?
    let title: String?
    let abstract: String?
    let publishedDate: String?
    let source: String?
    let updated: String?
    let desFacet: Facet?
    let orgFacet: Facet?
    let perFacet: Facet?
    let geoFacet: Facet?
    let media: [Media]?
    let uri: String?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case adxKeywords = "adx_keywords"
        case subsection = "subsection"
        case emailCount = "email_count"
        case countType = "count_type"
        case column = "column"
        case etaId = "eta_id"
        case section = "section"
        case id = "id"
        case assetId = "asset_id"
        case nytdsection = "nytdsection"
        case byline = "byline"
        case type = "type"
        case title = "title"
        case abstract = "abstract"
        case publishedDate = "published_date"
        case source = "source"
        case updated = "updated"
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media = "media"
        case uri = "uri"
    }
}

enum Facet: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Facet.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Facet"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}

// MARK: - Media
struct Media: Codable {
    let type: String?
    let subtype: String?
    let caption: String?
    let copyright: String?
    let approvedForSyndication: Int?
    let mediaMetadata: [MediaMetadatum]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case subtype = "subtype"
        case caption = "caption"
        case copyright = "copyright"
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String?
    let format: String?
    let height: Int?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case format = "format"
        case height = "height"
        case width = "width"
    }
}
