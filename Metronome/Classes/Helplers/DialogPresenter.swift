import UIKit

class DialogPresenter: NSObject, UIViewControllerTransitioningDelegate {
    func presentDialogViewController(_ viewControllerToPresent: UIViewController, formViewController parentViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        viewControllerToPresent.transitioningDelegate = self
        viewControllerToPresent.modalPresentationStyle = .custom
        
        parentViewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    func dismissDialogViewControllerFromPresentationViewController(_ presentationViewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        presentationViewController.dismiss(animated: animated, completion: completion)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideInAnimator()
    }
}
