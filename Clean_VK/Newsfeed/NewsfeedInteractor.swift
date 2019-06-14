//
//  NewsfeedInteractor.swift
//  Clean_VK
//
//  Created by Alan on 05/06/2019.
//  Copyright (c) 2019 Alan. All rights reserved.
//

import UIKit

protocol NewsfeedBusinessLogic {
  func makeRequest(request: Newsfeed.Model.Request.RequestType)
}

class NewsfeedInteractor: NewsfeedBusinessLogic {
  
  var presenter: NewsfeedPresentationLogic?
  var service: NewsfeedService?
  
  private let fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  func makeRequest(request: Newsfeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsfeedService()
    }
    
    switch request {
    case .getNewsFeed:
      fetcher.getFeed { [weak self] (feedResponse) in
        guard let feedResponse = feedResponse else { return }
        self?.presenter?.presentData(response: .presentNewsFeed(feed: feedResponse))
      }
    }
  }
  
}
