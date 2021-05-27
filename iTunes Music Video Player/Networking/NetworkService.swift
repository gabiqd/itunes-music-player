//
//  NetworkService.swift
//  iTunes Music Video Player
//
//  Created by Gabriel on 26/05/2021.
//

import Foundation
import UIKit

protocol MusicVideoService {
    func fetchMusicVideos(of searchTerm: String, completition: @escaping (Result<MusicVideoResult, NetworkError>) -> Void)
}

protocol ImageService {
    func fetchImage(imageURL url: URL, completition: @escaping(Result<UIImage, NetworkError>) -> Void)
}

class NetworkService: NSObject {
    fileprivate static func processResponse<T: Decodable>(data: Data?, response: URLResponse?, error: Error?) -> Result<T, NetworkError> {
        guard error == nil else {
            return .failure(.requestError)
        }
        
        guard let data = data else {
            return .failure(.nilDataResponseError)
        }
        
        let response = NetworkResponse(data: data)
        guard let decodedResponse = response.decode(T.self) else {
            return .failure(.decodingError)
        }
        
        return .success(decodedResponse)
    }
    
    fileprivate func requestFor(endpoint: Endpoints) -> URLRequest {
        guard let url = endpoint.url else { fatalError() }
        let httpMethod = endpoint.httpMethod
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        return request
    }
    
    private func submit<T: Decodable>(request: URLRequest, completition: @escaping (Result<T, NetworkError>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            let result = NetworkService.processResponse(data: data, response: response, error: error) as Result<T, NetworkError>
            completition(result)
        }
        task.resume()
    }
    
}

extension NetworkService: MusicVideoService {
    func fetchMusicVideos(of searchTerm: String, completition: @escaping (Result<MusicVideoResult, NetworkError>) -> Void) {
        let request = requestFor(endpoint: Endpoints.musicVideo(searchTerm: searchTerm))
        submit(request: request, completition: completition)
    }
}

extension NetworkService: ImageService {
    func fetchImage(imageURL url: URL, completition: @escaping (Result<UIImage, NetworkError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                let posterData = try Data(contentsOf: url)
                guard let image = UIImage(data: posterData) else {
                    
                    completition(.failure(.noImageError))
                    return
                }
                completition(.success(image))
            } catch (let error) {
                completition(.failure(.serverMessage(message: error.localizedDescription)))
            }
        }
    }
}
