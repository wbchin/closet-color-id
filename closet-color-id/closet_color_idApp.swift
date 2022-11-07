//
//  closet_color_idApp.swift
//  closet-color-id
//
//  Created by Waverly Chin on 10/8/22.
//

import SwiftUI

@main
struct closet_color_idApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environment(\.managedObjectContext,
                                       persistenceController.container.viewContext)
        }
    }
}
