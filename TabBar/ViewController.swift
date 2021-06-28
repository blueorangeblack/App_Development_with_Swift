//
//  ViewController.swift
//  TabBar
//
//  Created by min on 2021/05/28.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.badgeValue = "1"
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarItem.badgeValue = nil
    }
}

