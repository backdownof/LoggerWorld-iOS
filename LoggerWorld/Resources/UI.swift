//
//  UI.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 16.11.2020.
//

import Foundation

import UIKit

class UI {
    
    // MARK: - Public properties
    
    static var presentedController: UIViewController? {
        let topController = UIApplication.shared.windows.first!.rootViewController?.topController
        guard let navigation = topController as? UINavigationController else {
            return topController
        }
        return navigation.topViewController
    }
    
    // MARK: - Public methods
    
    static func setRootController(_ viewController: UIViewController?) {
        guard let viewController = viewController else { return }
        UIApplication.shared.windows.first?.setRootViewController(viewController)
    }
    
//    /**
//     Поделиться
//     - parameter items: данные для отправки
//     - parameter completion: возвращает через что поделились
//     */
//    static func share(_ items: [Any],
//                      _ completion: Constant.Block.string? = nil) {
//        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
//        activityController.completionWithItemsHandler = { (activityType, isSended, data, error) in
//            if isSended {
//                completion?(activityType?.rawValue ?? "")
//            }
//        }
//        presentedController?.present(activityController, animated: true, completion: nil)
//    }
    
}
