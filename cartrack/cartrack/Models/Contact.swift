//
//  Contact.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import MapKit

struct Response: Codable {
    var contacts: [Contact]
}

struct Contact: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: address
    let phone: String
    let website: String
    let company: company
}

struct address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: location
}

struct location: Codable {
    let lat: String
    let lng: String

    var latitude: Double {
        return Double(lat) ?? 0
    }

    var longitude: Double {
        return Double(lng) ?? 0
    }

    var coordinate: CLLocationCoordinate2D {
       return  CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }

    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
}

struct company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
