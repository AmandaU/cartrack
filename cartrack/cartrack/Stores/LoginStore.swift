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
    @Published var currentUser = User(id: -1, name: "", password: "", country: "")
    @Published var isLoggedIn = false
    @Published var errors = [Error]()
    @Published var isValid = true
  
    private var countryList = [String]()

    var db: SQLiteDatabase?

    var filePath: String {
        return  try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("test.sqlite").path
    }

    init() {
        do {
            self.db = try SQLiteDatabase.open(path: self.filePath )
            print("Successfully opened connection to database.")
            guard let db = self.db else {
                print("Successfully opened connection to database.")
                return
            }
            do {
                try db.createTable(table: User.self)
            } catch {
                print(db.errorMessage)
            }
            do {
                try db.insertUser(contact: User(id: 0, name: "test", password: "password", country: "South Africa"))
            } catch {
                print(db.errorMessage)
            }
        } catch SQLiteError.OpenDatabase(_) {
            print("Unable to open database.")

        } catch {
            print("Unable to open database.")
        }
        self.db = nil
    }

    func login(name: String, password: String, country: String, onDone: (Bool) -> Void) {

        do {
            self.db = try SQLiteDatabase.open(path: self.filePath )
            if let first = self.db!.contact(id: 0) {
                print("\(first.id) \(first.name)")
                if first.name as String == name &&
                    first.password as String == password  {
                    self.currentUser.id = first.id
                    self.currentUser.name = first.name
                    self.currentUser.password = first.password
                    self.currentUser.country = first.country
                    self.isLoggedIn.toggle()
                    onDone(true)
                } else {
                    self.isValid.toggle()
                    onDone(false)
                }
            }  }
        catch {
            self.isValid.toggle()
            onDone(false)
        }
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
