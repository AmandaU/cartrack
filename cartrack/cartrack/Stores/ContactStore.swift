//
//  ContactStore.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation
import Combine
import SwiftUI

class ContactStore: ObservableObject {
    @Published  var contacts = [Contact]()
    @Published  var contact: Contact?

    func getUsers() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            print("Invalid URL")
            return
        }
        print(url)
        var request = URLRequest(url: url)
        let headers = [
            // "Authorization": "Bearer \(accessToken)",
            "Accept": "*/*",
            "Content-Type": "application/json"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            #if DEBUG
            if let jsonString = String(data: data ?? Data(), encoding: .utf8) {
                print(jsonString)
            }
            #endif
            if let data = data {
                let jsonDecoder = JSONDecoder()
                if let decodedResponse = try? jsonDecoder.decode(Array<Contact>.self,from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.contacts = decodedResponse
                    }
                    return
                }

            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }

}
