//
//  NewsfeedPresenter.swift
//  Clean_VK
//
//  Created by Alan on 05/06/2019.
//  Copyright (c) 2019 Alan. All rights reserved.
//

import UIKit

protocol NewsfeedPresentationLogic {
  func presentData(response: Newsfeed.Model.Response.ResponseType)
}

class NewsfeedPresenter: NewsfeedPresentationLogic {
  weak var viewController: NewsfeedDisplayLogic?
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    
    switch response {
      
    case .presentNewsFeed(let feed):
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem)
      }
      
      let feedViewModel = FeedViewModel.init(cells: cells)
      viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
    return FeedViewModel.Cell.init(iconImageUrl: "",
                                   name: "",
                                   date: "",
                                   text: feedItem.text,
                                   likes: String(feedItem.likes?.count ?? 0),
                                   comments: String(feedItem.comments?.count ?? 0),
                                   shares: String(feedItem.reposts?.count ?? 0),
                                   views: String(feedItem.views?.count ?? 0))
  }
}
