//
//  ContentView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var navigationStore:  NavigationStore

    @State var bottomSheetShown = false

    var body: some View {

        ZStack{
           ViewComponent(screen: .none, view: AnyView(BlankView()))
            ViewComponent(screen: .main, view: AnyView(MainView()))
//            ViewComponent(screen: .user, view: AnyView(BlankView()))
//            ViewComponent(screen: .users, view: AnyView(BlankView()))
//            ViewComponent(screen: .map, view: AnyView(BlankView()))
        }
        .onAppear {
            self.navigationStore.navigate(screen: .main)
        }
//

     }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
