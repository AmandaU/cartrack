//
//  HeaderComponent.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

 struct HeaderComponent: View {
    @EnvironmentObject var navigationStore: NavigationStore
    @State var title: String

    private func onClick() {
        self.navigationStore.back()
    }
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(alignment: .top, spacing: 0) {
                    Text(self.title)
                        .font(.body)
                        .bold()
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
                HStack(alignment: .top, spacing: 0) {
                    Button(action: self.onClick) {
                        Text("Back")
                            .font(.body)
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                .padding()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color("orange"))
            .foregroundColor(Color.white)
        }
        .frame(height: 60)
    }
}


