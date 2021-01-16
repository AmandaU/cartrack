//
//  LoginStore.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Combine
import Foundation
import UIKit
import SwiftUI

class LoginStore: ObservableObject {
    @Published var isLoggedIn = false
    @Published var errors = [Error]()
    private var countryList = [String]()

    func login(name: String, password: String, onDone: (Bool) -> Void) {

        

    }

    var countries: [String] {
           if !self.countryList.isEmpty {
               return self.countryList
           }
           do {
               self.countryList = try jsonData(filename: "countries")
               return countryList
           } catch {
               print("no countries")
           }
           return self.countryList
       }

     func jsonData(filename: String) throws -> [String] {
            do {
                if let url = Bundle.main.url(forResource: filename, withExtension: "json" ) {
                    let data = try Data(contentsOf: url)
                    let JSON = try JSONSerialization.jsonObject(with: data, options: [])
                    print(".........." , JSON , ".......")
                    if let jsonArray = JSON as? [String] {
                        return jsonArray
                    }
                }
            } catch {
                return [""]
            }
            return [""]
        }

}
