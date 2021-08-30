//
//  AppSettings.swift
//  ChatApplication
//
//  Created by OPSolutions on 8/28/21.
//

import Foundation

enum AppSettings {
    static private let displayNameKey = "DisplayName"
    static private let emailKey = "Email Address"
    
    static var displayName: String {
        get {
            // swiftlint:disable:next force_unwrapping
            return UserDefaults.standard.string(forKey: displayNameKey)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: displayNameKey)
        }
    }
    
    static var currentEmail: String {
        get {
            // swiftlint:disable:next force_unwrapping
            return UserDefaults.standard.string(forKey: emailKey)!
        }
        set {
            UserDefaults.standard.set(newValue, forKey: emailKey)
        }
    }
}
