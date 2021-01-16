//
//  LoginView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI


struct LoginView: View {
    @EnvironmentObject var loginStore:  LoginStore
    @EnvironmentObject var navigationStore:  NavigationStore
    @State var name: String = ""
    @State var password: String = ""
    @State var country: String = ""
    @State private var selectedcountry: Int =  -1

    private func countryChange(_ tag: Int) {
        self.country = self.loginStore.countries[tag]
        self.loginStore.canLogin(name: self.name, password: self.password, country: self.country)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your username:")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            TextField("Enter username...", text: $name, onEditingChanged: { (changed) in
                print("Username onEditingChanged - \(changed)")
                self.loginStore.canLogin(name: self.name, password: self.password, country: self.country)
            }) {
                print("Username onCommit")
            }
            .autocapitalization(.none)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
            Text("Your password:")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            SecureField("Enter password...", text: $password)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
                .autocapitalization(.none)
            if #available(iOS 14.0, *) {
                Picker(selection: $selectedcountry.onChange(countryChange), label: Text("Please choose a country" ).padding(.horizontal).foregroundColor(.blue )) {
                    ForEach(0 ..< self.loginStore.countries.count) {
                        Text(self.loginStore.countries[$0])
                            .foregroundColor(.black)
                    }
                }
                .animation(nil)
                .pickerStyle(MenuPickerStyle())
            } else {
                Picker(selection: $selectedcountry.onChange(countryChange), label: Text("Please choose a country" ).padding(.horizontal).foregroundColor(.blue )) {
                    ForEach(0 ..< self.loginStore.countries.count) {
                        Text(self.loginStore.countries[$0])
                            .foregroundColor(.black)
                    }
                }
                .animation(nil)
            }
            Text("Your country: \(self.country)")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            Text("Your username or password are incorrect.")
                .font(.callout)
                .foregroundColor(.red)
                .padding(.horizontal)
                .show(isVisible: .constant(!self.loginStore.isValid))
            LoginButton(onLoggingIn: {
                self.loginStore.login(name: self.name, password: self.password, country: self.country) { (done) in
                    if (done) {
                        self.navigationStore.navigate(screen: .users)
                    }
                }
            })
                .padding(.horizontal)

        }
    }
}

private struct LoginButton: View {
    @EnvironmentObject var loginStore:  LoginStore

    @State var onLoggingIn: () -> Void

    private func onClick() {
        self.onLoggingIn()
    }

    var body: some View {
        Button(action: self.onClick, label: {
            Text("Login")
                .font(.body)
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding()
                .foregroundColor(Color.white)
                .background(Color("orange"))
        })
        .cornerRadius(10)
        .padding(.horizontal)
        .disabled(!self.loginStore.canLogin)
        .opacity(self.loginStore.canLogin ? 1 : 0.5)
    }
}
