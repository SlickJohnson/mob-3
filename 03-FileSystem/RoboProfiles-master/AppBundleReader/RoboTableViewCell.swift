//
//  RoboTableViewCell.swift
//  AppBundleReader
//
//  Created by Willie Johnson on 14/01/2018.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit

/// Displays Robo profile data.
class RoboTableViewCell: UITableViewCell {
  /// Robo's name.
  var name: String? {
    didSet {
      nameLabel.text = name
    }
  }
  /// Robo's personality.
  var personality: String? {
    didSet {
      personalityLabel.text = personality
    }
  }
  /// Robo's phrase.
  var phrase: String? {
    didSet {
      phraseLabel.text = phrase
    }
  }

  /// Displays the Robo's name.
  private var nameLabel: UILabel!
  /// Displays the Robo's personality.
  private var personalityLabel: UILabel!
  /// Displays the Robo's phrase.
  private var phraseLabel: UILabel!

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  /**
   Initialize Cell with labels to display Robo data.
   */
  func commonInit() {
    setupLabels()
  }
}

private extension RoboTableViewCell {
  /**
   Configure the labels to display robo data.
  */
  func setupLabels() {
    // Init
    nameLabel = UILabel(frame: .zero)
    personalityLabel = UILabel(frame: .zero)
    phraseLabel = UILabel(frame: .zero)
    addSubview(nameLabel)
    addSubview(personalityLabel)
    addSubview(phraseLabel)

    // Constraints
    nameLabel.snp.makeConstraints { (make) in
      make.left.top.right.equalToSuperview()
      make.height.equalToSuperview().dividedBy(3)
    }
    personalityLabel.snp.makeConstraints { (make) in
      make.top.equalTo(nameLabel.snp.bottom)
      make.left.right.equalToSuperview()
      make.bottom.equalTo(phraseLabel.snp.top)
    }
    phraseLabel.snp.makeConstraints { (make) in
      make.top.equalTo(personalityLabel.snp.bottom)
      make.left.right.equalToSuperview()
      make.bottom.equalToSuperview()
    }
  }
}
