//
//  BaseViewController.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit
import Toast_Swift
import SVProgressHUD

class BaseViewController: UIViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Loader
    func showLoading() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.isUserInteractionEnabled = false
        }
        SVProgressHUD.show()
    }
    
    func hideLoading() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.isUserInteractionEnabled = true
        }
        SVProgressHUD.dismiss()
    }
    
    //MARK: Alerts
    func showMessage(message: String) {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            if message.count > 0 {
                window.makeToast(message)
            }
        }        
    }
}
