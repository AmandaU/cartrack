//
//  ContactAnnotationItem.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/17.
//

import Foundation
import MapKit

struct ContactAnnotationItem: Identifiable {
    var coordinate: CLLocationCoordinate2D
    let id = UUID()
    let contactId: Int
}
