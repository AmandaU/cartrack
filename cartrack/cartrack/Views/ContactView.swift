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

    var region : MKCoordinateRegion {

        let lat =  Double(self.contactStore.contact?.address.geo.lat ?? "") ?? 0
        let lng =  Double(self.contactStore.contact?.address.geo.lng ?? "") ?? 0
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:lat, longitude: lng), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    //    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))


    var body: some View {
        ZStack {
            Background()
            VStack() {
                HeaderComponent( title: "Contact")

                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        Text(self.contactStore.contact?.name ?? "")
                            .font(.title)
                            .bold()
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(self.contactStore.contact?.email ?? "")
                            .bold()
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(self.contactStore.contact?.phone ?? "")
                            .bold()
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(self.contactStore.contact?.company.name ?? "")
                            .font(.body)
                            .bold()
                            .lineLimit(nil)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    MapView(region: self.region)
                        .frame(width: .infinity, height: UIScreen.main.bounds.height/2, alignment: .top)

                }
            }
        }
    }
}

private struct MapView: View {
    @State var region: MKCoordinateRegion

    var body: some View {
        Map(coordinateRegion: $region)
            .padding()
    }
}

private struct Background: View {
    var body: some View {
        Rectangle()
            .fill(Color("orange"))
            .edgesIgnoringSafeArea(.all)
    }
}



