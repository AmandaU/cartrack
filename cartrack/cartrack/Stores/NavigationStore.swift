//
//  NavigationStore.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import Combine

class NavigationStore: ObservableObject {
    enum Screen {
        case none
        case main
        case users
        case user
        case map
    }
    
    @Published var screen: Screen = .none
    @Published var history = [Screen]()
    
    public func navigate(screen: Screen) {
        self.screen = screen
        self.history.append(self.screen)
    }
    
    public func back() {
        _ = self.history.popLast()
        self.screen = self.history.last ?? .none
    }
}
