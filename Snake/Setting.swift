//
//  Setting.swift
//  Snake
//
//  Created by User08 on 2019/1/2.
//  

import Foundation

struct Setting: Codable {
    var name: String
    var speed: Int

    static func saveToFile(setting: Setting) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(setting) {
            UserDefaults.standard.setValue(data, forKey: "setting")
        }
    }
    
    static func readLoversFromFile() -> Setting? {
        let propertyDecoder = PropertyListDecoder()
        if let data = UserDefaults.standard.data(forKey: "setting"),
            let setting = try? propertyDecoder.decode(Setting.self, from: data) {
            return setting
        } else {
            let tmp=Setting(name:"",speed:1)
            
            let propertyEncoder = PropertyListEncoder()
            if let data = try? propertyEncoder.encode(tmp) {
                UserDefaults.standard.setValue(data, forKey: "setting")
            }
            
            return tmp
        }
    }
    
}
