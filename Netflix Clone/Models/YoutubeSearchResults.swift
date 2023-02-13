//
//  YoutubeSearchResults.swift
//  Netflix Clone
//
//  Created by Bakhtovar Umarov on 05/02/23.
//

import Foundation

struct YoutubeSearchResults: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable{
    let kind: String
    let videoId: String
}
