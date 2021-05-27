//
//  NetworkResponse.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation

struct NetworkResponse {
    fileprivate var data: Data
    init(data: Data){
        self.data = data
    }
}

extension NetworkResponse {
    public func decode<T: Decodable>(_ type: T.Type) -> T? {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(T.self, from: data)
            return response
        } catch _ {
            return nil
        }
    }
}

