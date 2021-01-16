//
//  ViewComponent.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct ViewComponent: View {
    @EnvironmentObject var navigationStore:  NavigationStore

    var screen:  NavigationStore.Screen
    var view: AnyView

    var body: some View {
        self.screen == self.navigationStore.screen
            ? self.view
            : AnyView(EmptyView())
    }
}

struct Covid19ScreenComponent_Previews: PreviewProvider {
    static var previews: some View {
       ViewComponent(screen: .none,
                        view: AnyView(Text("Hello World")))
            .environmentObject(NavigationStore())
    }
}
