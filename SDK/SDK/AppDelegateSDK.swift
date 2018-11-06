//
//  AppDelegateSDK.swift
//  SDK
//
//  Created by Renato Matos on 26/09/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

open class AppDelegateSDK: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?

    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if Platform.checkIfJailBroken() {
            fatalError("Not accessible by Jeail Broken Device. 👹")
        }

        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()

        return true
    }
}
