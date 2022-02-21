//
//  MatchViewCell.swift
//  FootballApp
//
//  Created by Mehmed on 2/21/22.
//

import UIKit

class MatchViewCell: UITableViewCell {
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = Fonts.bodyRegular()
        }
    }
    @IBOutlet weak var periodLabel: UILabel! {
        didSet {
            periodLabel.font = Fonts.bodyBold()
        }
    }
    @IBOutlet weak var notificationButton: UIButton! {
        didSet {
            notificationButton.setTitle(String(), for: .normal)
        }
    }
    @IBOutlet weak var homeImage: UIImageView! {
        didSet {
            homeImage.backgroundColor = Colors.teamBackgroundGray
            homeImage.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var awayImage: UIImageView! {
        didSet {
            awayImage.backgroundColor = Colors.teamBackgroundGray
            awayImage.layer.cornerRadius = 24
        }
    }
    @IBOutlet weak var homeNameLabel: UILabel! {
        didSet {
            homeNameLabel.font = Fonts.bodyBold()
        }
    }
    @IBOutlet weak var awayNameLabel: UILabel! {
        didSet {
            awayNameLabel.font = Fonts.bodyBold()
        }
    }
    @IBOutlet weak var homeScoreLabel: UILabel! {
        didSet {
            homeScoreLabel.font = Fonts.largeTitle()
        }
    }
    @IBOutlet weak var awayScoreLabel: UILabel! {
        didSet {
            awayScoreLabel.font = Fonts.largeTitle()
        }
    }
    @IBOutlet weak var venueLabel: UILabel! {
        didSet {
            venueLabel.font = Fonts.bodyRegular()
        }
    }
    @IBOutlet weak var tournamentLabel: UILabel! {
        didSet {
            tournamentLabel.font = Fonts.bodyRegular()
        }
    }
    @IBOutlet weak var centreButton: UIButton! {
        didSet {
            centreButton.setTitle("Match Centre", for: .normal)
            centreButton.titleLabel?.font = Fonts.bodyBold(size: 15)
        }
    }
    
    var notificationSelected: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = Colors.homebackgroundGray
    }
    
    func configure(match: Match) {
        dateLabel.text = match.formattedDate.toString()
        
        switch match.status {
        case .completed:
            periodLabel.text = match.period
        case .playing:
            periodLabel.text = "\(match.minute)"
        case .willBePlayed:
            periodLabel.text = String()
        }
        
        homeNameLabel.text = match.homeTeam.name
        awayNameLabel.text = match.awayTeam.name
        homeScoreLabel.text = "\(match.homeTeam.score)"
        awayScoreLabel.text = "\(match.awayTeam.score)"
        venueLabel.text = match.venue.name
        tournamentLabel.text = match.competition
    }
    
    @IBAction func notificationButtonTapped(_ sender: Any) {
        notificationSelected = !notificationSelected
        let buttonImage = notificationSelected ? UIImage(named: "ringOn") : UIImage(named: "ringOff")
        notificationButton.setImage(buttonImage, for: .normal)
    }
}
