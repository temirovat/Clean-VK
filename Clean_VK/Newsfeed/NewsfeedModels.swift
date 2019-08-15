//
//  NewsfeedModels.swift
//  Clean_VK
//
//  Created by Alan on 05/06/2019.
//  Copyright (c) 2019 Alan. All rights reserved.
//

import UIKit

enum Newsfeed {
  
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse)
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
}

struct FeedViewModel {
  struct Cell: FeedCellViewModel {
    var iconImageUrl: String
    var name: String
    var date: String
    var text: String?
    var likes: String?
    var comments: String?
    var shares: String?
    var views: String?
    var photoAttachment: FeedCellPhotoAttachmentViewModel?
    var sizes: FeedCellSizes
  }
  
  struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String?
    var width: Int
    var height: Int
  }
  
  let cells: [Cell]
}

