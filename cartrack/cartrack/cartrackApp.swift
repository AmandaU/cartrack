//
//  cartrackApp.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import SwiftUI

@main
struct cartrackApp: App {
    @Environment(\.scenePhase) private var scenePhase
  
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(NavigationStore())
                .environmentObject(LoginStore())
                .environmentObject(ContactStore())

        }
        .onChange(of: scenePhase) { (newScenePhase) in
                   switch newScenePhase {
                   case .active:
                       print("scene is now active!")
                   case .inactive:
                       print("scene is now inactive!")
                   case .background:
                       print("scene is now in the background!")
                   @unknown default:
                       print("Apple must have added something new!")
                   }
               }
    }
}
