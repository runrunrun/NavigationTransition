//
//  NavigationController.swift
//  NavigationTransition
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

protocol NavigationControllerDelegate {
    func popBackViewController(animated: Bool)
}

class NavigationController: UINavigationController {
    private var interactionController: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self

        let edgeSwipeGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        edgeSwipeGestureRecognizer.edges = .left
        view.addGestureRecognizer(edgeSwipeGestureRecognizer)
    }

    @objc func handleSwipe(_ gestureRecognizer: UIScreenEdgePanGestureRecognizer) {
        guard let gestureRecognizerView = gestureRecognizer.view else {
            interactionController = nil
            return
        }

        let percent = gestureRecognizer.translation(in: gestureRecognizerView).x / gestureRecognizerView.bounds.size.width

        if gestureRecognizer.state == .began {
            interactionController = UIPercentDrivenInteractiveTransition()

            // Let top viewController to pop based on it's internal logic.
            if let topViewController = self.viewControllers.last as? NavigationControllerDelegate {
                topViewController.popBackViewController(animated: true)
            } else {
                popViewController(animated: true)
            }
        } else if gestureRecognizer.state == .changed {
            interactionController?.update(percent)
        } else if gestureRecognizer.state == .ended {
            if percent > 0.5 && gestureRecognizer.state != .cancelled {
                interactionController?.finish()
            } else {
                interactionController?.cancel()
            }
            interactionController = nil
        }
    }

}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return TransitionAnimator(transitionType: .push)
        } else {
            return TransitionAnimator(transitionType: .pop)
        }
    }

    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
