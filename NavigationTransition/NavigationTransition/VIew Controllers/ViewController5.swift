//
//  ViewController5.swift
//  NavigationTransition
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

class ViewController5: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController5: NavigationControllerDelegate {
    func popBackViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
}
