//
//  MapView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/17.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: View {
    @EnvironmentObject var contactStore: ContactStore
    @Binding var bottomSheetShown: Bool

    var body: some View {
        ZStack {
            // BackgroundComponent()
            VStack() {
                HStack {
                    Spacer()
                    Text("Close")
                        .font(.body)
                        .bold()
                        .lineLimit(nil)
                        .padding(.trailing)
                        .foregroundColor(Color("orange"))
                        .multilineTextAlignment(.trailing)
                        .fixedSize(horizontal: false, vertical: true)
                        .onTapGesture {
                            self.bottomSheetShown.toggle()
                        }
                        .animation(.easeInOut)
                }
                Map(coordinateRegion: .constant(self.contactStore.region),
                    annotationItems: self.contactStore.isContact ?  self.contactStore.contactAnnotationItem :
                        self.contactStore.annotationItems) {item in
                    MapPin(coordinate: item.coordinate)
                }
            }
        }
    }
}

struct ContactAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
    let contactId: Int
}

