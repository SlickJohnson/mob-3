//
//  ViewController.swift
//  AppBundleReader
//
//  Created by Eliel A. Gordon on 10/26/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit

/// Shows a list of robots.
class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    if let robots = getRoboProfiles() {
      print(robots)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - Helper functions.
extension ViewController {
  func retrieveDataFromJSON(_ file: String) -> Data? {
    if let path = Bundle.main.path(forResource: file, ofType: "json") {
      do {
        return try Data(contentsOf: URL(fileURLWithPath: path))
      } catch {
        return nil
      }
    }
    return nil
  }

  func getRoboProfiles() -> [Robo]? {
    if let data = retrieveDataFromJSON("robo-profiles") {
      do {
        return try JSONDecoder().decode([Robo].self, from: data)
      } catch {
        print("ERRROROROROOR")
      }
    }
  }
}
