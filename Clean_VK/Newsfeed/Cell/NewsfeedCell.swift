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
}

class NewsfeedCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var sharesLabel: UILabel!
  @IBOutlet weak var viewsLabel: UILabel!
  
  
  func set(viewModel: FeedCellViewModel) {
    nameLabel.text = viewModel.name
    dateLabel.text = viewModel.date
    postLabel.text = viewModel.text
    likesLabel.text = viewModel.likes
    commentsLabel.text = viewModel.comments
    sharesLabel.text = viewModel.shares
    viewsLabel.text = viewModel.views
  }
}
