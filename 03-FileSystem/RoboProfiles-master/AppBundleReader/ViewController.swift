//
//  ViewController.swift
//  AppBundleReader
//
//  Created by Eliel A. Gordon on 10/26/17.
//  Copyright © 2017 Eliel Gordon. All rights reserved.
//

import UIKit
import SnapKit

/// Screen that shows a list of robots in a UITableView.
class ViewController: UIViewController {
  /// TableView for displaying robot profiles.
  lazy var tableView = UITableView()

  /// List of Robo Profiles.
  var roboProfiles: [Robo]?

  override func viewDidLoad() {
    super.viewDidLoad()

    if let robots = getRoboProfiles() {
      roboProfiles = robots
    }

    setupTableView()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

// MARK: - UI
private extension ViewController {
  /**
   Add and configure UITableView.
   */
  func setupTableView() {
    view.addSubview(tableView)

    // Constraints
    tableView.snp.makeConstraints { (make) in
      make.edges.equalTo(view)
    }

    // Options
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(RoboTableViewCell.self, forCellReuseIdentifier: "roboCell")
    
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 140
  }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {

}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let roboProfiles = roboProfiles else { return 0 }
    return roboProfiles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "roboCell") as? RoboTableViewCell else {
      return UITableViewCell()
    }

    guard let roboProfiles = roboProfiles else {
      return UITableViewCell()
    }

    let robo = roboProfiles[indexPath.row]

    cell.name = robo.name
    cell.personality = robo.personality
    cell.phrase = robo.phrase

    return cell
  }
}


// MARK: - AppBundle
private extension ViewController {
  /**
   Converts the file into Data.

   - Parameter file: The name of the file.

   - Returns: Optional Data of the file.
   */
  func retrieveDataFromJSON(_ file: String) -> Data? {
    guard let path = Bundle.main.path(forResource: file, ofType: "json") else { return nil}

    do {
      return try Data(contentsOf: URL(fileURLWithPath: path))
    } catch let error as NSError {
      print(error)
      return nil
    }
  }

  /**
   Decode robo-profiles.json file into [Robo]

   - Returns: An optional list of Robo objects.
   */
  func getRoboProfiles() -> [Robo]? {
    if let data = retrieveDataFromJSON("robo-profiles") {
      do {
        return try JSONDecoder().decode([Robo].self, from: data)
      } catch {
        return nil
      }
    }

    return nil
  }
}
