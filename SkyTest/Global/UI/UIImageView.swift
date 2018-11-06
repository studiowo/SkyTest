//
//  UIImageView.swift
//  SkyTest
//
//  Created by Renato Matos de Paula on 05/11/18.
//  Copyright © 2018 Renato Matos de Paula. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    //MARK: Network
    public func imageFrom(url: String, isShadow: Bool = false) {
        Alamofire.request(url).responseImage { response in
            DispatchQueue.main.async {
                if let image = response.result.value {
                    self.image = image
                } else {
                    self.contentMode = .scaleAspectFit
                    self.image = UIImage(named: "icon_sky")
                }
                
                UIView.animate(withDuration: 0.5, animations: {
                    self.alpha = 1
                    if isShadow {
                        self.setShadow()
                    }
                })
            }
        }
    }
    
    //MARK: Shadow
    func setShadow(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1).cgColor,
                                UIColor.black.withAlphaComponent(0).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        
        self.layer.mask = gradientLayer
    }
}
