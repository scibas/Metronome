import UIKit

class SlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let dimmViewTag = 9223421
    
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

fileprivate extension SlideInAnimator {
    
    func animatePresentation(_ transitionContext: UIViewControllerContextTransitioning) {
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let containerView = transitionContext.containerView
        
        let contentHeight = childViewController.view.intrinsicContentSize.height
        assert(contentHeight > 0, "Set up 'intrinsicContentSize.height' for presented ViewController's view")
        
        let dimmingView = UIView()
        dimmingView.tag = dimmViewTag
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.alpha = 0
        dimmingView.frame = containerView.bounds
        containerView.addSubview(dimmingView)
        
        containerView.addSubview(childViewController.view)
        
        childViewController.view.snp.remakeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(contentHeight)
        }
        
        containerView.layoutIfNeeded()
        
        childViewController.view.snp.remakeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(contentHeight)
        }
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                dimmingView.alpha = 1
                childViewController.view.alpha = 1
                containerView.layoutIfNeeded()
            },
            completion: { didCompleted in
                transitionContext.completeTransition(didCompleted)
            }
        )
    }
    
    func animateDismisal(_ transitionContext: UIViewControllerContextTransitioning) {
        let childViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let containerView = transitionContext.containerView
        let dimmingView = containerView.viewWithTag(dimmViewTag)

        let contentHeight = childViewController!.view.intrinsicContentSize.height
        assert(contentHeight > 0, "Set up 'intrinsicContentSize.height' for presented ViewController's view")
        
        childViewController?.view.snp.remakeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(contentHeight)
        }
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            animations: {
                dimmingView?.alpha = 0
                containerView.layoutIfNeeded()
            },
            completion: { didCompleted in
                dimmingView?.removeFromSuperview()
                transitionContext.completeTransition(didCompleted)
            }
        )
    }
}
