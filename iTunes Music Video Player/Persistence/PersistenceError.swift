//
//  PersistenceError.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation

enum PersistenceError: Error {
    case notFoundEntity
    case parsingError
    
    var message: String {
        switch self {
        case .notFoundEntity:
            return "Not found entity"
        case .parsingError:
            return "Parsing error"
        }
    }
}
