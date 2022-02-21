//
//  Resources.swift
//  FootballApp
//
//  Created by Mehmed on 2/21/22.
//

import Foundation
import UIKit

typealias Colors = Resources.Colors
typealias Fonts = Resources.Fonts
typealias Images = Resources.Images

struct Resources {
    
    struct Colors {
        static let homebackgroundGray = #colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)
        static let teamBackgroundGray = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
    }
    
    struct Fonts {
        static func bodyRegular(size: CGFloat = 13) -> UIFont{
            guard let font = UIFont(name: "Roboto-Regular", size: size) else {
                return UIFont.systemFont(ofSize: size)
            }
            return font
        }
        
        static func bodyBold(size: CGFloat = 13) -> UIFont{
            guard let font = UIFont(name: "Roboto-Bold", size: size) else {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return font
        }
        
        static func title(size: CGFloat = 22) -> UIFont{
            guard let font = UIFont(name: "Roboto-Bold", size: size) else {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return font
        }
        
        static func largeTitle(size: CGFloat = 34) -> UIFont{
            guard let font = UIFont(name: "Roboto-Bold", size: size) else {
                return UIFont.boldSystemFont(ofSize: size)
            }
            return font
        }
    }
    
    struct Images {
        static let notificationOnIcon: UIImage = UIImage(named: "ringOn") ?? UIImage()
        static let notificationOffIcon: UIImage = UIImage(named: "ringOff") ?? UIImage()
        static let backIcon: UIImage = UIImage(named: "backIcon") ?? UIImage()
    }
}
