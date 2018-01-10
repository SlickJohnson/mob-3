//
//  ViewController.swift
//  userdefaults-chain
//
//  Created by Willie Johnson on 10/01/2018.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit
import KeychainSwift

class ViewController: UIViewController {
  lazy var label = UILabel(frame: view.frame)
  lazy var textField = UITextField(frame: CGRect(x: 0, y: 50, width: 375, height: 22))
  let keychain = KeychainSwift()

  override func viewDidLoad() {
    super.viewDidLoad()
    testUserDefaults()
    testKeyChain()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

private extension ViewController {
  func testUserDefaults() {
    view.addSubview(label)
    label.textColor = .red

    if UserDefaults.standard.bool(forKey: "hasSeenApp") {
      if let password = keychain.get("password") {
        label.text = "Your password is: \(password)"
      } else {
        label.text = "Password please..."
      }
    } else {
      label.text = "Hey welcome!"
      UserDefaults.standard.set(true, forKey: "hasSeenApp")
    }
  }

  func testKeyChain() {
    view.addSubview(textField)
    textField.textColor = .red
    textField.placeholder = "Gimmie your password!"
    textField.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)

  }

  @objc func textFieldDidChange(textField: UITextField) {
    guard let text = textField.text else { return }

    if text.count < 20 {
      label.text = "THAT PASSWORD IS TOO SHORT"
      label.font = label.font.withSize(CGFloat((textField.text?.count)! + 12))
    } else {
      label.font = label.font.withSize(12)
      label.text = "That's better :)... You can leave now thank you."
    }

    keychain.set(text, forKey: "password")
  }
}
