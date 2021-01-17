//
//  ContactView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI
import MapKit

struct ContactView: View {
    @EnvironmentObject var contactStore: ContactStore
    @State var bottomSheetShown = false

    private func onClick() {
        self.bottomSheetShown.toggle()
    }

    var body: some View {
        ZStack {
            BackgroundComponent()
            GeometryReader { geometry in
                VStack() {
                    HeaderComponent( title: "Contact")
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(self.contactStore.contact?.name ?? "")
                                .font(.title)
                                .bold()
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Email: \(self.contactStore.contact?.email ?? "")")
                                .bold()
                                .lineLimit(nil)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Phone: \(self.contactStore.contact?.phone ?? "")")
                                .bold()
                                .lineLimit(nil)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Location: \(self.contactStore.contact?.address.geo.lat ?? "") : \(self.contactStore.contact?.address.geo.lng ?? "")")
                                .bold()
                                .lineLimit(nil)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            Text("Company: \(self.contactStore.contact?.company.name ?? "")")
                                .font(.body)
                                .bold()
                                .lineLimit(nil)
                                .padding(.horizontal)
                                .foregroundColor(Color.white)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
                            HStack {
                            ImageView()
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0,  maxHeight: .infinity, alignment: .center)
                            }
                        }
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
                .onDisappear {
                    self.contactStore.isContact = false
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
    }
}

private struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    let images = ["https://cdn.pixabay.com/photo/2015/12/01/20/28/road-1072823_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2015/06/19/21/24/the-road-815297_960_720.jpg",
                  "https://cdn.pixabay.com/photo/2015/12/01/20/28/fall-1072821_960_720.jpg",
                  "https://image.shutterstock.com/image-photo/country-road-450w-628141070.jpg"]

    init() {
        let number = Int.random(in: 0..<4)
        imageLoader = ImageLoader(urlString:images[number])
    }

    var body: some View {

            Image(uiImage: image)
                .resizable()
                .cornerRadius(18)
                .aspectRatio(contentMode: .fit)
                //.frame(width:100, height:100)
                .onReceive(imageLoader.didChange) { data in
                self.image = UIImage(data: data) ?? UIImage()
        }
    }
}


