//
//  UIViewController+Extension.swift
//  FootballApp
//
//  Created by Mehmed on 2/21/22.
//

import Foundation
import UIKit

extension UIViewController {
    func setDefaultNavigationBar(with title: String){
        self.title = title
        self.navigationController?.navigationBar.backgroundColor = .white
        
        let backImage = Images.backIcon.withRenderingMode(.alwaysTemplate)
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backButton.image = backImage
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
}
