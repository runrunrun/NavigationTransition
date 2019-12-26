//
//  ViewController3.swift
//  NavigationTransition
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ViewController3: NavigationControllerDelegate {
    func popBackViewController(animated: Bool) {
        print("Pop ViewController3")
        navigationController?.popViewController(animated: animated)
    }
}
