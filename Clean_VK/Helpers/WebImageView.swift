//
//  WebImageView.swift
//  Clean_VK
//
//  Created by Alan on 15/06/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

class WebImageView: UIImageView {
  
  func set(imageURL: String?) {
    guard let imageURL = imageURL, let url = URL(string: imageURL) else { return }
    
    if let cachedImage = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
      image = UIImage(data: cachedImage.data)
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
      DispatchQueue.main.async {
        if let data = data, let response = response {
          self?.image = UIImage(data: data)
          self?.handleLoadedImage(data: data, response: response)
        }
      }
    }
    dataTask.resume()
  }
  
  private func handleLoadedImage(data: Data, response: URLResponse) {
    guard let responseURL = response.url else { return }
    let cachedResponse = CachedURLResponse(response: response, data: data)
    URLCache.shared.storeCachedResponse(cachedResponse, for: URLRequest(url: responseURL))
  }
  
}
