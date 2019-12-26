//
//  ViewController2.swift
//  NavigationTransition
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController2: NavigationControllerDelegate {
    func popBackViewController(animated: Bool) {
        print("Pop ViewController2")
        navigationController?.popViewController(animated: animated)
    }
}
