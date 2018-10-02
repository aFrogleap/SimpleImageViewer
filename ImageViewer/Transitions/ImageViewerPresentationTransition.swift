import UIKit

final class ImageViewerPresentationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    private let fromImageView: UIImageView
    
    init(fromImageView: UIImageView) {
        self.fromImageView = fromImageView
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let fromParentView = fromImageView.superview!
        
        let imageView = AnimatableImageView()
        imageView.image = fromImageView.image
        imageView.frame = fromParentView.convert(fromImageView.frame, to: nil)
        imageView.contentMode = fromImageView.contentMode
        
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = .black
        fadeView.alpha = 0.0
        
        toView.frame = containerView.bounds
        toView.isHidden = true
        // Do not hide the view by setting its 'isHidden' property. A UIStackView removes hidden subviews from the visual hierarchy. Therefore, the layout jumps when switched to visible after dismissal.
        //        fromImageView.isHidden = true
        fromImageView.alpha = 0
        
        containerView.addSubview(toView)
        containerView.addSubview(fadeView)
        containerView.addSubview(imageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,  animations: {
                        imageView.contentMode = .scaleAspectFit
                        imageView.frame = containerView.bounds
                        fadeView.alpha = 1.0
        }, completion: { _ in
            toView.isHidden = false
            toView.alpha = 1
            fadeView.removeFromSuperview()
            imageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }
}

