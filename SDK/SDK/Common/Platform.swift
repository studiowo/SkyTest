//
//  Platform.swift
//  SDK
//
//  Created by Renato Matos on 01/10/18.
//  Copyright © 2018 Renato Matos. All rights reserved.
//

import Foundation

struct Platform {
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }

    static func checkIfJailBroken() -> Bool {
        if !Platform.isSimulator {
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string:"cydia://package/com.example.package")!) {
                return true
            }
        }

        let stringToWrite = "JBTextBV"
        do
        {
            try stringToWrite.write(toFile:"/private/JBTextBV.txt", atomically:true, encoding:String.Encoding.utf8)
            return true
        } catch
        {
            return false
        }
    }
}
