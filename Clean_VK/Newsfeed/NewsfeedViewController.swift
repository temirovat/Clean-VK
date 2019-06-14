//
//  NewsfeedViewController.swift
//  Clean_VK
//
//  Created by Alan on 05/06/2019.
//  Copyright (c) 2019 Alan. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
  
  var interactor: NewsfeedBusinessLogic?
  var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
  
  private var feedViewModel = FeedViewModel.init(cells: [])
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: Setup
  
  private func setup() {
    let viewController        = self
    let interactor            = NewsfeedInteractor()
    let presenter             = NewsfeedPresenter()
    let router                = NewsfeedRouter()
    viewController.interactor = interactor
    viewController.router     = router
    interactor.presenter      = presenter
    presenter.viewController  = viewController
    router.viewController     = viewController
  }
  
  // MARK: Routing
  
  
  
  // MARK: View lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    tableView.register(UINib(nibName: String(describing: NewsfeedCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NewsfeedCell.self))
    
    interactor?.makeRequest(request: .getNewsFeed)
  }
  
  func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
    switch viewModel {
    case .displayNewsFeed(let feedViewModel):
      self.feedViewModel = feedViewModel
      tableView.reloadData()
    }
  }
}

extension NewsfeedViewController: UITableViewDelegate {
  
}

extension NewsfeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return feedViewModel.cells.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsfeedCell.self), for: indexPath) as! NewsfeedCell
    let cellViewModel = feedViewModel.cells[indexPath.row]
    cell.set(viewModel: cellViewModel)
    return cell
  }
  
  
}
