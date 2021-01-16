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
                    }
                    MapView()
                        .frame(width: .infinity, height: UIScreen.main.bounds.height/2, alignment: .top)
                }
            }
        }
    }
}

private struct MapView: View {
    @EnvironmentObject var contactStore: ContactStore

    var lat: Double {
        return Double(self.contactStore.contact?.address.geo.lat ?? "") ?? 0
    }

    var lon:  Double {
        return  Double(self.contactStore.contact?.address.geo.lng ?? "") ?? 0
    }

    var region : MKCoordinateRegion {
        return MKCoordinateRegion(center: self.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    }

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.lat, longitude: self.lon)
    }

    var annotationItems: [MyAnnotationItem] {
        return [ MyAnnotationItem(coordinate: self.coordinate)]
    }

    var body: some View {
        Map(coordinateRegion: .constant(self.region),
            annotationItems: self.annotationItems) {item in
            MapPin(coordinate: item.coordinate)
        }

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

struct MyAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
}



