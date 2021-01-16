//
//  BindingExtension.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import  SwiftUI

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        return Binding(
            get: { self.wrappedValue },
            set: { selection in
                self.wrappedValue = selection
                handler(selection)
        })
    }
}
