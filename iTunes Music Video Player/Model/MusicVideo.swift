//
//  MusicVideo.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation

struct MusicVideo: Decodable {
    let artistName: String
    let trackCensoredName: String
    let artworkUrl100: URL?
    let previewUrl: URL?
}

struct MusicVideoResult: Decodable {
    let results: [MusicVideo]
}
