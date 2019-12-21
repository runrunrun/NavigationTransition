//
//  TransitionAnimator.swift
//  CustomTransitionDemo
//
//  Created by Kunwar, Hari on 12/15/19.
//  Copyright © 2019 Kunwar, Hari. All rights reserved.
//

import UIKit

final class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    enum TransitionType {
        case push
        case pop
    }

    let type: TransitionType

    init(transitionType type: TransitionType) {
        self.type = type
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }

        let duration = transitionDuration(using: transitionContext)

        let container = transitionContext.containerView
        if type == .push {
            container.addSubview(toView)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }

        addDropShadowToLeftEdge(view: toView)
        addDropShadowToLeftEdge(view: fromView)

        let toViewFinalCenterX = toView.center

        print(container)

        let viewOffset: CGFloat = container.bounds.width*0.3

        let toViewStartingCenterX = type == .push ? container.center.x + container.bounds.width : container.center.x - viewOffset
        toView.center = CGPoint(x: toViewStartingCenterX, y: toView.center.y)

        let animationOptions: UIView.AnimationOptions = transitionContext.isInteractive ? .curveLinear : .curveEaseOut
        print(transitionContext.isInteractive)

        UIView.animate(withDuration: duration, delay: 0.0, options: animationOptions, animations: {
            toView.alpha = 1.0
            fromView.alpha = self.type == .push ? 0.8 : 1.0

            toView.center = toViewFinalCenterX

            if self.type == .push {
                fromView.center = CGPoint(x: container.center.x - viewOffset, y: container.center.y)
            } else {
                fromView.center = CGPoint(x: container.center.x + container.bounds.width,
                                          y: container.center.y)
            }
        }) { (_) in
            container.addSubview(toView)
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }

    private func addDropShadowToLeftEdge(view: UIView) {
        let shadowPath = UIBezierPath(rect: view.frame)
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: -0.5, height: 0)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 0.1
        view.layer.masksToBounds =  false
        view.layer.shadowPath = shadowPath.cgPath
    }
}
