//
//  User.swift
//  nscoding
//
//  Created by Willie Johnson on 10/01/2018.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import Foundation

class User: NSObject, NSCoding {
  var username: String!
  var password: String!

  init(username: String, password: String) {
    self.username = username
    self.password = password
  }

  required convenience init?(coder aDecoder: NSCoder) {
    guard let username = aDecoder.decodeObject(forKey: "username") as? String else { return nil }
    guard let password = aDecoder.decodeObject(forKey: "password") as? String else { return nil }

    self.init(username: username, password: password)
  }

  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.username, forKey: "username")
    aCoder.encode(self.password, forKey: "password")
  }
}
