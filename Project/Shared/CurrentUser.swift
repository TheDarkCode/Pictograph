//
//  CurrentUser.swift
//  Pictograph
//
//  Created by Adam Boyd on 2015-10-25.
//  Copyright © 2015 Adam Boyd. All rights reserved.
//

import Foundation

//Need to use hungarian notation with the keys because that is how it was originally, it would be possible to change it later
private let firstTimeOpeningAppKey = "kFirstTimeOpeningAppKey"
private let encryptionEnabledKey = "kEncryptionEnabledKey"
private let encryptionPasswordKey = "kEncryptionKey"
private let showPasswordOnScreenKey = "showPasswordOnScreenKey"
private let nightModeEnabledKey = "nightModeEnabledKey"
private let shouldStoreImagesKey = "shouldStoreImagesKey"
private let shrinkEncodedImagesKey = "shrinkEncodedImages"

class CurrentUser: NSObject, NSCoding, NSSecureCoding {
    var firstTimeOpeningApp: Bool = true
    var encryptionEnabled: Bool = false
    var encryptionPassword: String = ""
    var showPasswordOnScreen: Bool = true
    var nightModeEnabled: Bool = false
    var shouldStoreImages: Bool = true //iOS only, stores images once
    var shrinkEncodedImages: Bool = true
    
    override init() { super.init() }
    
    // MARK: - NSCoding
    required init?(coder aDecoder: NSCoder) {
        //Variables in from start
        
        //First time opening app
        if let firstTimeOpeningAppNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: firstTimeOpeningAppKey) {
            firstTimeOpeningApp = firstTimeOpeningAppNumber.boolValue
        }
        
        //Encryption enabled
        if let encryptionEnabledNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: encryptionEnabledKey) {
            encryptionEnabled = encryptionEnabledNumber.boolValue
        }
        
        //Encryption key
        if let storedEncryptionPassword = aDecoder.decodeObject(forKey: encryptionPasswordKey) as? String {
            encryptionPassword = storedEncryptionPassword
        }
        
        
        //Variables added in 1.1
        
        //Showing the password on screen
        if let showPasswordOnScreenNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: showPasswordOnScreenKey) {
            showPasswordOnScreen = showPasswordOnScreenNumber.boolValue
        }
        
        //Variables added in 1.2
        
        //If night mode is enabled
        if let nightModeEnabledNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: nightModeEnabledKey) {
            nightModeEnabled = nightModeEnabledNumber.boolValue
        }
        
        // Variables added in 1.4
        if let shouldStoreImagesNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: shouldStoreImagesKey) {
            self.shouldStoreImages = shouldStoreImagesNumber.boolValue
        }
        
        //Variables added in 1.5
        if let shrinkEncodedImagesNumber = aDecoder.decodeObject(of: NSNumber.self, forKey: shrinkEncodedImagesKey) {
            self.shrinkEncodedImages = shrinkEncodedImagesNumber.boolValue
        }
        
    }
    
    func encode(with aCoder: NSCoder) {
        let firstTimeOpeningAppNumber = NSNumber(value: firstTimeOpeningApp)
        aCoder.encode(firstTimeOpeningAppNumber, forKey: firstTimeOpeningAppKey)
        
        let encryptionEnabledNumber = NSNumber(value: encryptionEnabled)
        aCoder.encode(encryptionEnabledNumber, forKey: encryptionEnabledKey)
        
        aCoder.encode(encryptionPassword, forKey: encryptionPasswordKey)
        
        let showPasswordOnScreenNumber = NSNumber(value: showPasswordOnScreen)
        aCoder.encode(showPasswordOnScreenNumber, forKey: showPasswordOnScreenKey)
        
        let nightModeEnabledNumber = NSNumber(value: nightModeEnabled)
        aCoder.encode(nightModeEnabledNumber, forKey: nightModeEnabledKey)
        
        let shouldStoreImagesNumber = NSNumber(value: self.shouldStoreImages)
        aCoder.encode(shouldStoreImagesNumber, forKey: shouldStoreImagesKey)
        
        let shrinkEncodedImagesNumber = NSNumber(value: self.shrinkEncodedImages)
        aCoder.encode(shrinkEncodedImagesNumber, forKey: shrinkEncodedImagesKey)
    }
    
    // MARK: - NSSecureCoding
    class var supportsSecureCoding: Bool {
        return true
    }
}
