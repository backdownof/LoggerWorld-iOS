//
//  UIViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 16.11.2020.
//

import UIKit

extension UIViewController {
    
    // MARK: - Public properties
    
    var topController: UIViewController {
        return presentedViewController?.topController ?? self
    }
    
    var isModal: Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    var isViewShown: Bool {
        return isViewLoaded && view.window != nil
    }
    
}
