//
//  NetworkService.swift
//  Clean_VK
//
//  Created by Alan on 26/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import Foundation

protocol Networking {
    func request(path: String, parameters: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
    
    private let authService: AuthService
    
    init(authService: AuthService = AppDelegate.shared().authService) {
        self.authService = authService
    }
    
    func request(path: String, parameters: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = authService.token else { return }
        
        var allParams = parameters
        allParams["access_token"] = token
        allParams["v"] = VKAPI.vkVersion
        
        guard let feedURL = url(from: path, parameters: allParams) else { return }
        
        let request = URLRequest(url: feedURL)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask  {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data,error)
            }
        })
    }
    
    private func url(from path: String, parameters: [String: String]) -> URL? {
        var components = URLComponents()
        components.scheme = VKAPI.scheme
        components.host = VKAPI.host
        components.path = path
        components.queryItems = parameters.map({ URLQueryItem.init(name: $0, value: $1) })
        
        guard let componentsURL = components.url else { return nil }
        return componentsURL
    }
}
