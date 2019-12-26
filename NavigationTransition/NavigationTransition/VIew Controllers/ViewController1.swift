//
//  ViewController1.swift
//  NavigationTransition
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController1: NavigationControllerDelegate {
    func popBackViewController(animated: Bool) {
        print("Pop ViewController1")
        navigationController?.popViewController(animated: animated)
    }
}

