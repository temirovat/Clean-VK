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
  
  private var dateFormatter: DateFormatter = {
    let dt = DateFormatter()
    dt.locale = Locale(identifier: "ru_RU")
    dt.dateFormat = "d MMM 'в' HH:mm"
    return dt
  }()
  
  func presentData(response: Newsfeed.Model.Response.ResponseType) {
    
    switch response {
      
    case .presentNewsFeed(let feed):
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
      }
      
      let feedViewModel = FeedViewModel.init(cells: cells)
      viewController?.displayData(viewModel: .displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
    
    let profile = self.profile(for: feedItem.sourceId, with: profiles, and: groups)
    
    let date = Date(timeIntervalSince1970: feedItem.date)
    let dateTitle = dateFormatter.string(from: date)
    let photoAttachment = self.photoAttachment(feedItem: feedItem)
    
    return FeedViewModel.Cell.init(iconImageUrl: profile.photo,
                                   name: profile.name,
                                   date: dateTitle,
                                   text: feedItem.text,
                                   likes: String(feedItem.likes?.count ?? 0),
                                   comments: String(feedItem.comments?.count ?? 0),
                                   shares: String(feedItem.reposts?.count ?? 0),
                                   views: String(feedItem.views?.count ?? 0),
                                   photoAttachment: photoAttachment,
                                   sizes: <#FeedCellSizes#>)
  }
  
  private func profile(for sourseId: Int, with profiles: [Profile], and groups: [Group]) -> ProfileRepresentable {
    
    let profilesOrGroups: [ProfileRepresentable] = sourseId >= 0 ? profiles : groups
    let normalSourseId = sourseId >= 0 ? sourseId : -sourseId
    let profileRepresentable = profilesOrGroups.first { (myProfileRepresentable) -> Bool in
      myProfileRepresentable.id == normalSourseId
    }
    
    return profileRepresentable!
  }
  
  private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
    guard
      let photos = feedItem.attachments?.compactMap({ $0.photo }),
      let firstPhoto = photos.first else {
      return nil
    }
    return FeedViewModel.FeedCellPhotoAttachment.init(photoUrlString: firstPhoto.srcBIG,
                                                      width: firstPhoto.width,
                                                      height: firstPhoto.height)
  }
  
}
