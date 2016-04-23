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
    let rString1 = NSAttributedString(string: "amazing", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.396, green: 0.82, blue: 0.396, alpha: 1), NSFontAttributeName: font ])
    let rString2 = NSAttributedString(string: "beautiful", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.953, green: 0.612, blue: 0.0706, alpha: 1), NSFontAttributeName: UIFont.boldSystemFontOfSize(20) ])
    let rString3 = NSAttributedString(string: "different", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.204, green: 0.596, blue: 0.859, alpha: 1), NSFontAttributeName: UIFont.italicSystemFontOfSize(20) ])
    let rString4 = NSAttributedString(string: "an experience.", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1), NSFontAttributeName: font ])

    label.animationWithFixedString(fixedString, replaceableStrings: [rString1, rString2, rString3, rString4], typeSpeed: 0.1, delay: 2) {
      UIView.animateWithDuration(1) {
        self.subtitleLabel.alpha = 1
      }
    }
  }
}
