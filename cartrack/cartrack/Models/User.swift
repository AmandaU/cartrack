//
//  User.swift
//  cartrack
//
//  Created by Amanda Baret on 2021/01/16.
//

import Foundation


struct User {
  var id: Int32
  var name: String
  var password: String
  var country: String
}

extension User: SQLTable {
  static var createStatement: String {
    return "CREATE TABLE User(Id INT PRIMARY KEY NOT NULL, Name CHAR(255), Password CHAR(255), Country CHAR(255));"
  }
}
