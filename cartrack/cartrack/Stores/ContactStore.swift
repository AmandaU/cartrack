//
//  ContactStore.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import Combine
import SwiftUI
import MapKit

class ContactStore: ObservableObject {
    @Published var contacts = [Contact]()
    @Published var contact: Contact?
    @Published var annotationItems = [ContactAnnotationItem]()
    @Published var isContact = false

    var cancellationToken: AnyCancellable?

    func getContacts(onDone: @escaping () ->Void) {
        cancellationToken = ContactApi.getContacts()
            .sink(receiveCompletion: { _ in
            },
            receiveValue: {
                self.contacts = $0
                self.annotationItems = self.contacts.map({ (contact) -> ContactAnnotationItem in
                    let coordinate = CLLocationCoordinate2D(latitude: contact.address.geo.latitude, longitude: contact.address.geo.longitude)
                    return ContactAnnotationItem(coordinate:  coordinate, contactId: contact.id)
                })
                onDone()
            })
    }

    var contactAnnotationItem: [ContactAnnotationItem] {
        if let contact = self.contact {
            return [self.annotationItems.first(where: {$0.contactId == contact.id})!]
        }
        return [ContactAnnotationItem(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0),contactId: -1)]
    }

    var region : MKCoordinateRegion {
        if self.isContact {
            return MKCoordinateRegion(center: self.contact?.address.geo.coordinate ?? CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        } else {
            let coordinates = self.annotationItems.map { (item) -> CLLocationCoordinate2D in
                return CLLocationCoordinate2D(latitude: item.coordinate.latitude, longitude: item.coordinate.longitude)
            }
            return MKCoordinateRegion(coordinates: coordinates)
        }
    }
}
