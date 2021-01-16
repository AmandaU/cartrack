//
//  ContactView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct ContactView: View {
    @EnvironmentObject var contactStore: ContactStore

    var body: some View {
        ZStack {
            Background()
            VStack() {
                HeaderComponent( title: "Contact")
                ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Text(self.contactStore.contact?.name ?? "")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color.white)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(self.contactStore.contact?.email ?? "")
                        .bold()
                        .lineLimit(nil)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(self.contactStore.contact?.phone ?? "")
                        .bold()
                        .lineLimit(nil)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    Text(self.contactStore.contact?.company.name ?? "")
                        .font(.body)
                        .bold()
                        .lineLimit(nil)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
                }
            }
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



