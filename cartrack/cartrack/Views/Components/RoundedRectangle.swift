//
//  RoundedRectangle.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/17.
//

import Foundation
import SwiftUI

struct RoundedRectangleComponent: Shape {
    var cornerRadius: CGFloat = .infinity
    var corners: UIRectCorner = [.allCorners]

    init(cornerRadius: CGFloat, corners: UIRectCorner) {
        self.cornerRadius =  cornerRadius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )
        return Path(path.cgPath)
    }
}
