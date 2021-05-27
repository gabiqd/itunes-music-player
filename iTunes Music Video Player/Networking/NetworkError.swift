//
//  NetworkError.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation

enum NetworkError: Error {
    case decodingError
    case requestError
    case nilDataResponseError
    case noImageError
    case serverMessage(message: String)
    
    var message: String{
        switch self{
        case .decodingError:
            return "We have an error decoding the response"
        case .requestError:
            return "An error doing the request ocurred"
        case .nilDataResponseError:
            return "We have received an empty response"
        case .noImageError:
            return "No image"
        case .serverMessage(let message):
            return message
        }
    }
}

