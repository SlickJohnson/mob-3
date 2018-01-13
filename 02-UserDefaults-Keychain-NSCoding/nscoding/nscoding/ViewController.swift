//
//  ViewController.swift
//  nscoding
//
//  Created by Willie Johnson on 10/01/2018.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!

  var user: User!
  var fullPath: URL!

  override func viewDidLoad() {
    super.viewDidLoad()
    fullPath = getDocumentsDirectory().appendingPathComponent("user")

    if let user = NSKeyedUnarchiver.unarchiveObject(withFile: fullPath.absoluteString) as? User {
      print(user)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func login(_ sender: Any) {
    guard let username = usernameTextField.text, let password = passwordTextField.text else { return }

    user = User(username: username, password: password)
    let userdata = NSKeyedArchiver.archivedData(withRootObject: user)

    do {
      try userdata.write(to: fullPath)
    } catch {
      print("error")
    }
  }

  func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}

