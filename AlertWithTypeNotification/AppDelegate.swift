//
//  AppDelegate.swift
//  AlertWithTypeNotification
//
//  Created by Hưng Nguyễn on 9/7/21.
//  Email: hungnguyen.it36@gmail.com
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    class var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

}

extension AppDelegate {
    func getCurrentViewController() -> UIViewController? {
          
          // If the root view is a navigation controller, we can just return the visible ViewController
          if let navigationController = getNavigationController() {
              
              return navigationController.visibleViewController
          }
          
          // Otherwise, we must get the root UIViewController and iterate through presented views
          if let rootController = UIApplication.shared.keyWindow?.rootViewController {
              
              var currentController: UIViewController! = rootController
              
              // Each ViewController keeps track of the view it has presented, so we
              // can move from the head to the tail, which will always be the current view
              while (currentController.presentedViewController != nil) {
                  
                  currentController = currentController.presentedViewController
              }
              return currentController
          }
          return nil
      }
      
    
    func getNavigationController() -> UINavigationController? {
        
        if let navigationController = UIApplication.shared.keyWindow?.rootViewController  {
            
            return navigationController as? UINavigationController
        }
        return nil
    }
}

extension UIApplication {
    
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        
        if let nav = base as? UINavigationController, let vc = nav.visibleViewController {
            return topViewController(base: vc)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }

}
