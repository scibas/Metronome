import UIKit

class DialogPresenter: NSObject, UIViewControllerTransitioningDelegate {
    func presentDialogViewController(viewControllerToPresent: UIViewController, formViewController parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerToPresent.transitioningDelegate = self
        viewControllerToPresent.modalPresentationStyle = .Custom
        
        applyPopupThemeToViewController(viewControllerToPresent)
        
        parentViewController.presentViewController(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    func dismissDialogViewControllerFromPresentationViewController(presentationViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentationViewController.dismissViewControllerAnimated(animated, completion: completion)
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopupAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopupAnimator()
    }
    
    private func applyPopupThemeToViewController(viewController: UIViewController) {
        viewController.view.layer.borderColor = UIColor.darkGrayColor().CGColor
        viewController.view.layer.borderWidth = 1.0
    }
}