import UIKit

class PopupAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	fileprivate let dimmViewTag = 123418923

	struct PopupMargins {
		static let side = 50.0
		static let top = 150.0
		static let bottom = 100.0
	}

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return 0.25
	}

	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let destinationViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!

		if (destinationViewController.isBeingPresented) {
			animatePresentation(transitionContext)
		} else {
			animateDismisal(transitionContext)
		}
	}
}

private extension PopupAnimator {
	func animatePresentation(_ transitionContext: UIViewControllerContextTransitioning) {
		let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
		let containerView = transitionContext.containerView

		let dimmingView = UIView()
		dimmingView.tag = dimmViewTag
		dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
		dimmingView.alpha = 0
		dimmingView.frame = containerView.bounds
		containerView.addSubview(dimmingView)

		childViewController.view.alpha = 0
		containerView.addSubview(childViewController.view)

        childViewController.view.snp.remakeConstraints { (make) in
			make.top.equalTo(containerView).offset(PopupMargins.top)
			make.bottom.equalTo(containerView).offset(-PopupMargins.bottom)
			make.leading.equalTo(containerView).offset(PopupMargins.side)
			make.trailing.equalTo(containerView).offset(-PopupMargins.side)
		}

		UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
			animations: {
				dimmingView.alpha = 1
				childViewController.view.alpha = 1
			},
			completion: { didCompleted in
				transitionContext.completeTransition(didCompleted)
			}
		)
	}

	func animateDismisal(_ transitionContext: UIViewControllerContextTransitioning) {
		let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
		let containerView = transitionContext.containerView
		let dimmingView = containerView.viewWithTag(dimmViewTag)!

		UIView.animate(withDuration: self.transitionDuration(using: transitionContext),
			animations: {
				dimmingView.alpha = 0
				childViewController?.view.alpha = 0
			},
			completion: { didCompleted in
				dimmingView.removeFromSuperview()
				transitionContext.completeTransition(didCompleted)
			}
		)
	}
}
