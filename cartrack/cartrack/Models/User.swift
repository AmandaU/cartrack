//
//  User.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation


struct User {
  let id: Int32
  let name: String
  let password: String
  let country: String
}

extension User: SQLTable {
  static var createStatement: String {
    return "CREATE TABLE User(Id INT PRIMARY KEY NOT NULL, Name CHAR(255), Password CHAR(255), Country CHAR(255));"
  }
}
