//
//  FeedViewController.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import UIKit

class FeedViewController: UIViewController {
    private let feedRepository = FeedRepository()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        getFeed()
    }
    
    private func getFeed(){
        feedRepository.getFeed { [weak self] feed in
            print("aaa")
        } failure: { [weak self] error in
            print(error)
        }

    }
    
}
