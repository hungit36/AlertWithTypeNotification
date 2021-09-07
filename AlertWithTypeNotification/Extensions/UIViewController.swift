//
//  UIViewController.swift
//  AlertWithTypeNotification
//
//  Created by Hưng Nguyễn on 9/7/21.
//  Email: hungnguyen.it36@gmail.com
//

import UIKit

extension UIViewController{
    
    func showAlertWithTypeNotification(title: String? = nil, message: String? = nil, showCloseButton: Bool = false, isSuccess: Bool = true, timeShow: TimeInterval = 5.0) {
        let rootView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: UIApplication.shared.getTopPadding()), size: CGSize(width: self.view.bounds.width, height: 64)))
        rootView.backgroundColor = isSuccess ? .blue : .red
        rootView.tag = -999
        let closeButton = UIButton(frame: .zero)
        let closeButtonSize : CGFloat = 30
        if showCloseButton {
            closeButton.frame.size.width = closeButtonSize
            closeButton.frame.size.height = closeButtonSize
            closeButton.frame.origin.x = rootView.frame.width - closeButtonSize - 5
            closeButton.frame.origin.y = 0
            closeButton.setImage(UIImage(named: "close"), for: .normal)
            closeButton.addTarget(self, action: #selector(closeAlertWithTypeNotification), for: .touchUpInside)
            closeButton.isHidden = true
            rootView.addSubview(closeButton)
        }
        
        rootView.isUserInteractionEnabled = true
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        swipeUp.direction = .up
        rootView.addGestureRecognizer(swipeUp)
        
        let titleLabel = UILabel(frame: CGRect(origin: CGPoint(x: 15, y: 15), size: CGSize(width: closeButton.frame.origin.x != .zero ? closeButton.frame.origin.x - 20 : 15, height: 0)))
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.isHidden = true
        titleLabel.sizeToFit()
        rootView.addSubview(titleLabel)
        
        let messagelabel = UILabel(frame: CGRect(origin: CGPoint(x: titleLabel.frame.origin.x, y: titleLabel.frame.origin.y + titleLabel.frame.size.height + 5), size: CGSize(width: rootView.frame.size.width - 30, height: 0)))
        messagelabel.text = message
        messagelabel.textColor = .white
        messagelabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        messagelabel.isHidden = true
        messagelabel.sizeToFit()
        rootView.addSubview(messagelabel)
        
        rootView.frame.size.height = 0
        if let rootVC = AppDelegate.shared.window?.rootViewController {
            rootVC.view.addSubview(rootView)
            UIView.animate(withDuration: 0.25) {
                rootView.frame.size.height = messagelabel.frame.origin.y + messagelabel.frame.size.height + 15
            } completion: { finish in
                if finish {
                    for subView in rootView.subviews {
                        subView.isHidden = false
                    }
                    self.hideAlertWithTyoeNotification(timeShow: timeShow)
                }
            }
        }
    }
    
    @objc private func handleGesture(_ gesture: UISwipeGestureRecognizer) {
       if gesture.direction == .right {
            print("Swipe Right")
       }
       else if gesture.direction == .left {
            print("Swipe Left")
       }
       else if gesture.direction == .up {
        self.closeAlertWithTypeNotification()
            print("Swipe Up")
       }
       else if gesture.direction == .down {
            print("Swipe Down")
       }
    }
    
    @objc private func closeAlertWithTypeNotification() {
        if let rootVC = AppDelegate.shared.window?.rootViewController,let rootView = rootVC.view.viewWithTag(-999) {
            
            UIView.animate(withDuration: 0.25) {
                rootView.frame.size.height = 0
                for subView in rootView.subviews.reversed() {
                    if rootView.frame.origin.y == subView.frame.origin.y + subView.frame.size.height {
                        subView.isHidden = true
                    }
                }
            } completion: { finish in
                if finish {
                    rootView.removeFromSuperview()
                }
            }

        }
    }
    
    private func hideAlertWithTyoeNotification(timeShow: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + timeShow) { // Change `2.0` to the desired number of seconds.
           // Code you want to be delayed
            self.closeAlertWithTypeNotification()
        }
    }
    
    func show(in viewController: UIViewController, completed: @escaping()->()) {
        providesPresentationContextTransitionStyle = true
        definesPresentationContext = true
        modalPresentationStyle = UIModalPresentationStyle.overFullScreen
        modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        viewController.present(self, animated: true) {
            completed()
        }
    }
    
    var isHiddenNaviStatus: Bool? {
        return navigationController?.isNavigationBarHidden
    }
    
    var isHiddenTabbarStatus: Bool? {
        return navigationController?.tabBarController?.tabBar.isHidden
    }
    
    func setTabbarHidden(isHidden: Bool?) {
        navigationController?.tabBarController?.tabBar.isHidden = isHidden ?? true
        navigationController?.tabBarController?.tabBar.isTranslucent = isHidden ?? true
    }
    
    func setNavigationHidden(isHidden: Bool?, animated: Bool = false) {
        self.navigationController?.setNavigationBarHidden(isHidden ?? true, animated: animated)
    }
    
    class func instantiateFrom(storyboard: String? = nil, identifier: String? = nil) -> Self
        {
            return _instantiate(storyboard: storyboard, identifier: identifier)
        }
        
        fileprivate class func _instantiate<T: UIViewController>(storyboard: String?, identifier: String?) -> T {
            let _storyboard = (storyboard != nil) ? storyboard! : String(describing: self)
            let _identifier = (identifier != nil) ? identifier! : String(describing: self)
            let storyboard = UIStoryboard(name: _storyboard, bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: _identifier) as! T
            return controller
        }
}
