//
//  MainView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct MainView: View {
    @EnvironmentObject var loginStore: LoginStore
    @State var bottomSheetShown = true

    var body: some View {
            ZStack {
                Background()
                GeometryReader { geometry in
//                    Text("Hello, world!")
//                        .padding()
                    Image("cartrack")
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
                    if self.bottomSheetShown {
                        BottomSheetView(
                            isOpen: self.$bottomSheetShown,
                            maxHeight: geometry.size.height * 0.88
    
                        ) {
                            ScrollView {
                                LoginView()
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.bottomSheetShown = !self.loginStore.isLoggedIn
            }
    }
}

private struct Background: View {
    var body: some View {
        Rectangle()
            .fill(Color("orange"))
            .edgesIgnoringSafeArea(.all)
    }
}

