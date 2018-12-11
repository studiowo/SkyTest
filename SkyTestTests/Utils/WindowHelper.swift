//
//  WindowHelper.swift
//  SkyTestTests
//
//  Created by Renato Matos de Paula on 04/12/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit

import UIKit

class WindowHelper {
    
    static var testWindow: UIWindow = {
        let window = UIWindow(frame: CGRect(x:0, y:0, width: 320, height: 640))
        return window
    }()
    
    static func showInTestWindow(viewController: UIViewController) {
        WindowHelper.testWindow.rootViewController = viewController
        WindowHelper.testWindow.makeKeyAndVisible()
    }
}

