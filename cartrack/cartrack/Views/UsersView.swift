//
//  UsersView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct UsersView: View {
    var body: some View {
        ZStack {
            Background()
        }
    }
}

private struct Background: View {
    var body: some View {
        Rectangle()
            .fill(Color("orange"))
            .edgesIgnoringSafeArea(.all)
    }
}
