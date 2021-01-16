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
    @State var username: String = ""
    @State var password: String = ""
    @State var country: String = ""
    @State private var selectedcountry: Int =  -1

    private func countryChange(_ tag: Int) {
        self.country = self.loginStore.countries[tag]
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Your username:")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            TextField("Enter username...", text: $username)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Your password:")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            SecureField("Enter password...", text: $password)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Text("Your country: \(self.country)")
                .font(.callout)
                .bold()
                .padding(.horizontal)
            if #available(iOS 14.0, *) {
                Picker(selection: $selectedcountry.onChange(countryChange), label: Text("Please choose a country" ).padding(.horizontal).foregroundColor(.blue )) {
                    ForEach(0 ..< self.loginStore.countries.count) {
                        Text(self.loginStore.countries[$0])
                            .foregroundColor(.black)
                    }
                }
                .animation(nil)
                .pickerStyle(MenuPickerStyle())

            }
            LoginButton()
                .padding(.horizontal)

        }
    }
}

private struct LoginButton: View {
    @EnvironmentObject var loginStore: LoginStore

    private func onClick() {
        // self.loginStore.userSubjects.hasClickedLogin.send()
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
        //            .overlay(RoundedRectangle(cornerRadius: 10)
        //                        .stroke(//(, lineWidth: 2)
        //)
        .padding(.horizontal)
        // .disabled(self.loginStore.status != .idle)
    }
}
