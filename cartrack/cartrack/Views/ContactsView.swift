//
//  ContactsView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct ContactsView: View {
    @EnvironmentObject var contactStore: ContactStore
    @EnvironmentObject var navigationStore: NavigationStore

    var body: some View {
        ZStack {
            Background()
            VStack() {
                HeaderComponent(title: "Contacts")
                ZStack {
                    Loading().show(isVisible: .constant(self.contactStore.contacts.isEmpty))
                    List(self.contactStore.contacts, id: \.id) { item in
                        HStack() {
                            Text(item.name)
                                .font(.headline)
                                .foregroundColor(Color("orange"))
                                .bold()
                                .frame(alignment: .leading)
                            Spacer()
                            Text(item.company.name)
                                .font(.headline)
                                .foregroundColor(Color("orange"))
                                .frame(alignment: .trailing)

                        }
                        .onTapGesture {
                            self.contactStore.contact = item
                            self.navigationStore.navigate(screen: .contact)
                        }
                        .padding()
                    }
                    .show(isVisible: .constant(!self.contactStore.contacts.isEmpty))
                }
            }
        }
        .onAppear{
            self.contactStore.getUsers ()
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

private struct Loading: View {

    var body: some View {
        VStack {
            SpinnerComponent(
                isAnimating: .constant(true),
                color: UIColor.white,
                style: .large
            )
            .foregroundColor(Color.white)
            .padding()
            Text("Fetching contacts")
                .foregroundColor(Color.white)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(minWidth: 0, maxWidth: .infinity)
                .fixedSize(horizontal: false, vertical: false)
                .padding()
        }
        .background(Color.clear)
    }
}

