//
//  ViewController.swift
//  TypeOutAnimationLabel
//
//  Created by Buu Bui on 04/22/2016.
//  Copyright (c) 2016 Buu Bui. All rights reserved.
//

import UIKit
import TypeOutAnimationLabel
class ViewController: UIViewController {

  @IBOutlet weak var label: TypeOutAnimationLabel!
  @IBOutlet weak var subtitleLabel: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.subtitleLabel.alpha = 0
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.start), userInfo: nil, repeats: false)
  }

  func start() {
    let font = UIFont.systemFontOfSize(20)
    let fixedString = NSAttributedString(string: "San Francisco is ", attributes: [NSForegroundColorAttributeName: UIColor(red: 0.38, green: 0.388, blue: 0.404, alpha: 1), NSFontAttributeName: font])

    let replacableStrings = ["amazing", "beautiful", "different", "an experience."].map { text -> NSAttributedString in
      return NSAttributedString(string: text, attributes: [NSForegroundColorAttributeName: UIColor(red: 0.396, green: 0.82, blue: 0.396, alpha: 1), NSFontAttributeName: font])
    }

    label.animationWithFixedString(fixedString, replacableStrings: replacableStrings, typeSpeed: 0.1, delay: 2) {
      UIView.animateWithDuration(1) {
        self.subtitleLabel.alpha = 1
      }
    }
  }
}
