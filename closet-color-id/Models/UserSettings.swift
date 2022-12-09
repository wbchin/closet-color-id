//
//  UserSettings.swift
//  closet-color-id
//
//  Created by Allison Cao on 12/6/22.
//

import Foundation
import Combine

class UserSettings: ObservableObject {
    @Published var isFirstTimeUser: Bool
    
    init() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
           UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            self.isFirstTimeUser = true
        } else {
            self.isFirstTimeUser = false
        }
    }
}
