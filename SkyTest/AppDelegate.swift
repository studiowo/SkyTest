//
//  AppDelegate.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit
import SDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = self.window else {
            fatalError()
        }
        
        let urlEnvironment = SDKEnvironment.URLEnvironment(
            baseURL: "https://sky-exercise.herokuapp.com/api",
            version: "",
            clientSecret: "",
            clientID: "",
            sslCertificates: [])
        
        SDKEnvironment(urlEnvironment: urlEnvironment,
                       accessCode: "1234567890",
                       window: window, authProtocol: self).setup()
        
        window.rootViewController = MoviesCoordinator.start().rootViewController
        window.makeKeyAndVisible()
        
        UINavigationBar.appearance().barTintColor = UIColor.black.withAlphaComponent(0.7)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().isTranslucent = true
        
        return true
    }
}

extension AppDelegate: AuthProtocol {
    func needsAuthenticate(success: () -> Void) {}
}

