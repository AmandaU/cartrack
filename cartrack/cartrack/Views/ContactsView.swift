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
    @State var bottomSheetShown = false

    private func onClick() {
        self.bottomSheetShown.toggle()
    }

    var body: some View {
        ZStack {
            BackgroundComponent()
            GeometryReader { geometry in
                VStack() {
                    HeaderComponent(title: "Contacts")
                    ZStack {
                        Loading().show(isVisible: .constant(self.contactStore.contacts.isEmpty))
                        VStack {
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
                                    self.contactStore.isContact = true
                                    self.contactStore.contact = item
                                    self.navigationStore.navigate(screen: .contact)
                                }
                                .padding()
                            }
                            Button(action: self.onClick, label: {
                                Text("Map")
                                    .font(.body)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(Color("orange"))
                                    .background(Color.white)
                            })
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .edgesIgnoringSafeArea(.bottom)
                        }
                        .show(isVisible: .constant(!self.contactStore.contacts.isEmpty))
                    }
                }
                if self.bottomSheetShown {
                    BottomSheetView(
                        isOpen: self.$bottomSheetShown,
                        maxHeight: geometry.size.height * 0.88

                    ) {
                            MapView(bottomSheetShown: self.$bottomSheetShown)
                    }
                    .animation(.easeInOut)
                }
            }
        }
        .onAppear{
            self.contactStore.getContacts {}
        }
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

