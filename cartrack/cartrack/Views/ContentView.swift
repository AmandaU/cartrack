//
//  ContentView.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import SwiftUI

struct ContentView: View {

    @State var bottomSheetShown = false

    var body: some View {

        ZStack {
            GeometryReader { geometry in
                Text("Hello, world!")
                    .padding()
                if self.bottomSheetShown {
                    BottomSheetView(
                        isOpen: self.$bottomSheetShown,
                        maxHeight: geometry.size.height * 0.88

                    ) {
                        ScrollView {
                            LoginView()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
