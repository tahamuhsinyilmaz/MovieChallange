//
//  MainNavigationController.swift
//  MovieChallange
//
//  Created by onedio on 24.09.2020.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([ListViewController()], animated: false)
    }

}
