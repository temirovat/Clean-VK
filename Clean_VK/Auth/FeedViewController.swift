//
//  FeedViewController.swift
//  Clean_VK
//
//  Created by Alan on 25/05/2019.
//  Copyright © 2019 Alan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {
    
    let dataFetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        dataFetcher.getFeed { (feedResponse) in
            guard let feedResponse = feedResponse else { return }
            feedResponse.items.map({ (feedItem) in
                print(feedItem.date)
            })
        }
        
    }
}
