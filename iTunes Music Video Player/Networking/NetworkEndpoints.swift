//
//  NetworkEndpoints.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation

enum Endpoints {
    case musicVideo(searchTerm: String)
    
    var url: URL?{
        let host = "itunes.apple.com"
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        
        switch self {
        case .musicVideo(let searchTerm):
            components.path = "/search"
            components.queryItems = [
                URLQueryItem(name: "term", value: searchTerm),
                URLQueryItem(name: "entity", value: "musicVideo")
            ]
        }
        
        return components.url
    }
    
    var httpMethod: String {
        switch self {
        case .musicVideo:
            return "GET"
        }
    }
}
