//
//  BlankView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import SwiftUI

struct BlankView: View {
    var body: some View {
        Color.white.edgesIgnoringSafeArea(.all)
    }
}

#if DEBUG
struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        var body: some View {
            BlankView()
        }
    }
}
#endif
