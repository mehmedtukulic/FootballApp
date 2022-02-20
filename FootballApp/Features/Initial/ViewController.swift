//
//  ViewController.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeed()
    }
    
    private func loadFeed(){
        let vc = FeedViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

