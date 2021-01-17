//
//  BackgroundComponent.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/17.
//

import Foundation
import SwiftUI

struct BackgroundComponent: View {
    var body: some View {
        Rectangle()
            .fill(Color("orange"))
            .edgesIgnoringSafeArea(.all)
    }
}
