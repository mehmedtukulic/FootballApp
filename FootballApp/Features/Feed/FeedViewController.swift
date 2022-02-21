//
//  FeedViewController.swift
//  FootballApp
//
//  Created by Mehmed on 2/20/22.
//

import UIKit

class FeedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            let xib = UINib(nibName: "MatchViewCell", bundle: nil)
            tableView.register(xib, forCellReuseIdentifier: "MatchViewCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.backgroundColor = Colors.homebackgroundGray
        }
    }
    
    let viewModel = FeedViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDefaultNavigationBar(with: "Fixtures list")
    }
    
    private func bindViewModel(){
        viewModel.getFeed()
    
        viewModel.feedMatches.bind { [weak self] matches in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegates
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         viewModel.feedMatches.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchViewCell", for: indexPath) as! MatchViewCell
        let match = viewModel.feedMatches.value[indexPath.row]
        cell.configure(match: match)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 231
    }
    
}
