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

    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        let headers = [
            // "Authorization": "Bearer \(accessToken)",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            #if DEBUG
            if let jsonString = String(data: data ?? Data(), encoding: .utf8) {
                print(jsonString)
            }
            #endif
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let decodedResponse = try? jsonDecoder.decode(Array<Contact>.self,from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.contacts = decodedResponse
                        self.annotationItems = self.contacts.map({ (contact) -> ContactAnnotationItem in
                            let coordinate = CLLocationCoordinate2D(latitude: contact.address.geo.latitude, longitude: contact.address.geo.longitude)
                            return ContactAnnotationItem(coordinate:  coordinate, contactId: contact.id)
                        })
                    }
                    return
                }

            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
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
