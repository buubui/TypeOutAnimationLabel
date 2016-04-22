//
//  TypeOutAnimationLabel.swift
//  Pods
//
//  Created by Buu Bui on 4/22/16.
//
//

import UIKit

public class TypeOutAnimationLabel: UILabel {
  enum Status: Int {
    case Forward, Backward
  }
  var canBackward: Bool {
    return currentReplaceableIndex < replaceableStrings.count - 1
  }

  private var fixedString = NSAttributedString()
  private var replaceableStrings = [NSAttributedString]()
  private var currentReplaceableIndex = 0

  private var fixedLength: Int {
    return fixedString.string.characters.count
  }

  private var currentReplaceableLength: Int {
    if currentReplaceableIndex >= replaceableStrings.count {
      return 0
    }
    return replaceableStrings[currentReplaceableIndex].string.characters.count
  }
  private var status: Status = .Forward
  private var currentIndex = 0
  private var currentLength = 0

  private func reset() {
    currentReplaceableIndex = 0
    currentIndex = 0
    initReplaceableStringAtIndex(currentReplaceableIndex)
  }

  private func initReplaceableStringAtIndex(index: Int) {
    status = .Forward
    currentLength = fixedLength + currentReplaceableLength
  }

  func next() {
    switch status {
    case .Forward:
      currentIndex += 1
      if canBackward && currentIndex > currentLength {
        currentIndex -= 2
        status = .Backward
      }
    case .Backward:
      if currentIndex >= fixedLength {
        currentIndex -= 1
      } else {
        currentReplaceableIndex += 1
        initReplaceableStringAtIndex(currentReplaceableIndex)
      }
    }
  }

  func canAnimateNext() -> Bool {
    switch status {
    case .Backward:
      if currentReplaceableIndex == replaceableStrings.count - 1 {
        return currentIndex <= fixedLength
      }
      return true
    default:
      return canBackward ? true : currentIndex <= currentLength
    }
  }

  var currentFixedString: NSAttributedString {
    let index = [currentIndex, fixedLength].minElement()!
    return fixedString.attributedSubstringFromRange(NSRange(location: 0, length: index))
  }

  var currentReplaceableString: NSAttributedString? {
    let index = [currentIndex + 1 - fixedLength, currentReplaceableLength].minElement()!
    if index <= 0 {
      return nil
    }

    return replaceableStrings[currentReplaceableIndex].attributedSubstringFromRange(NSRange(location: 0, length: index))
  }

  func computeText() -> NSAttributedString {
    let text = NSMutableAttributedString(attributedString: currentFixedString)
    if let replaceableString = currentReplaceableString {
      text.appendAttributedString(replaceableString)
    }
    return text
  }

  override public func drawRect(rect: CGRect) {
    attributedText = computeText()
    super.drawRect(rect)
  }

  public func animationWithFixedString(fixedString: NSAttributedString, replaceableStrings: [NSAttributedString], typeSpeed: NSTimeInterval, delay: NSTimeInterval, completion: (() -> Void)?) {
    self.fixedString = fixedString
    self.replaceableStrings = replaceableStrings
    reset()
    animation(typeSpeed: typeSpeed, delay: delay, completion: completion)
  }

  func animation(typeSpeed typeSpeed: NSTimeInterval, delay: NSTimeInterval, completion: (() -> Void)?) {
    if currentIndex == fixedLength && status == .Forward {
      NSThread.sleepForTimeInterval(delay)
    }
    UIView.animateWithDuration(typeSpeed, delay: delay, options: .CurveEaseInOut, animations: {
      self.setNeedsDisplay()
    }) { _ in
      NSThread.sleepForTimeInterval(typeSpeed)
      self.next()
      if self.canAnimateNext() {
        self.animation(typeSpeed: typeSpeed, delay: delay, completion: completion)
      } else {
        completion?()
      }
    }
  }
}
