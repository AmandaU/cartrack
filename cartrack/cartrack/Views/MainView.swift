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
    @State var bottomSheetShown = false

    var body: some View {
        ZStack {
            BackgroundComponent()
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Image("cartrack")
                        .frame(width: 200, height: 200, alignment: .center)
                     .padding(.horizontal)
                        .cornerRadius(100)
                    Spacer()
                    LoginButton(bottomSheetShown: self.$bottomSheetShown)
                    Spacer()
                }
                if self.bottomSheetShown {
                    BottomSheetView(
                        isOpen: self.$bottomSheetShown,
                        maxHeight: geometry.size.height * 0.88

                    ) {
                        ScrollView {
                            LoginView(bottomSheetShown: self.$bottomSheetShown)
                        }
                    }
                    .animation(.easeInOut)
                }
            }
        }
        //            .onAppear {
        //                self.bottomSheetShown = !self.loginStore.isLoggedIn
        //            }
    }
}

private struct LoginButton: View {
    @EnvironmentObject var loginStore:  LoginStore
    @EnvironmentObject var navigationStore:  NavigationStore

    @Binding var bottomSheetShown: Bool

    private func onClick() {
        if self.loginStore.isLoggedIn {
            self.navigationStore.navigate(screen: .contacts)
        }   else {
            self.bottomSheetShown.toggle()
        }
    }

    var body: some View {
        Button(action: self.onClick, label: {
            Text("Login")
                .font(.body)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color("orange"))
                .background(Color.white)
        })
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

