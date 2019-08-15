//
//  NewsfeedCell.swift
//  Clean_VK
//
//  Created by Alan on 11/06/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
  var iconImageUrl: String { get }
  var name: String { get }
  var date: String { get }
  var text: String? { get }
  var likes: String? { get }
  var comments: String? { get }
  var shares: String? { get }
  var views: String? { get }
  var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
  var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
  var postLabelFrame: CGRect { get }
  var attachmentFrame: CGRect { get }
}

protocol FeedCellPhotoAttachmentViewModel {
  var photoUrlString: String? { get }
  var width: Int { get }
  var height: Int { get }
}

class NewsfeedCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: WebImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var sharesLabel: UILabel!
  @IBOutlet weak var viewsLabel: UILabel!
  @IBOutlet weak var postImageView: WebImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    iconImageView.layer.cornerRadius = iconImageView.frame.height / 2
    iconImageView.clipsToBounds = true
  }
  
  
  func set(viewModel: FeedCellViewModel) {
    iconImageView.set(imageURL: viewModel.iconImageUrl)
    nameLabel.text = viewModel.name
    dateLabel.text = viewModel.date
    postLabel.text = viewModel.text
    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    sharesLabel.text = viewModel.shares
    viewsLabel.text = viewModel.views
    
    if let photoAttachment = viewModel.photoAttachment {
      postImageView.set(imageURL: photoAttachment.photoUrlString)
      postImageView.isHidden = false
    } else {
      postImageView.isHidden = true
    }
  }
}
