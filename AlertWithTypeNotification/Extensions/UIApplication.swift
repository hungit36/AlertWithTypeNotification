//
//  UIApplication.swift
//  AlertWithTypeNotification
//
//  Created by Hưng Nguyễn on 9/7/21.
//  Email: hungnguyen.it36@gmail.com
//

import UIKit

extension UIApplication{
    
    func isEdgeToEdge()-> Bool {
        if getTopPadding() > 24{
            return true
        }
        return false
    }
    func getTopPadding() -> CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0
    }
}
