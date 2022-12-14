//
//  SearchResponce.swift
//  Json Itunes
//
//  Created by Olegio on 03.09.2022.
//

import Foundation

struct SearchResponce: Decodable {
    var resultCount: Int
    var results: [Track]
}

struct Track: Decodable {
    var trackName: String?
    var collectionName: String?
    var artistName: String?
    var artworkUrl60: String?
}
