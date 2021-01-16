//
//  ViewExtensions.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

extension View {
    func show(isVisible: Binding<Bool>) -> some View {
        ModifiedContent(content: self, modifier: Show(isVisible: isVisible))
    }
}

struct Show: ViewModifier {
    @Binding var isVisible: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isVisible {
            content
        } else {
            content.hidden()
        }
    }
}
