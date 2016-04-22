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
    return currentReplacableIndex < replacableStrings.count - 1
  }

  private var fixedString = NSAttributedString()
  private var replacableStrings = [NSAttributedString]()
  private var currentReplacableIndex = 0

  private var fixedChars = [String]()
  private var currentReplacableChars = [String]()
  private var status: Status = .Forward
  private var currentIndex = 0
  private var currentLength = 0

  private func reset() {
    fixedChars = fixedString.string.characters.map {String($0)}
    currentReplacableIndex = 0
    currentIndex = 0
    initReplacableStringAtIndex(currentReplacableIndex)
  }

  private func initReplacableStringAtIndex(index: Int) {
    currentReplacableChars = replacableStrings[index].string.characters.map {String($0)}
    status = .Forward
    currentLength = fixedChars.count + currentReplacableChars.count
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
      if currentIndex >= fixedChars.count {
        currentIndex -= 1
      } else {
        currentReplacableIndex += 1
        initReplacableStringAtIndex(currentReplacableIndex)
      }
    }
  }

  func canAnimateNext() -> Bool {
    switch status {
    case .Backward:
      if currentReplacableIndex == replacableStrings.count - 1 {
        return currentIndex <= fixedChars.count
      }
      return true
    default:
      return canBackward ? true : currentIndex <= currentLength
    }
  }

  var currentFixedString: NSAttributedString {
    let index = [currentIndex, fixedChars.count].minElement()!
    return fixedString.attributedSubstringFromRange(NSRange(location: 0, length: index))
  }

  var currentReplacableString: NSAttributedString? {
    let index = [currentIndex + 1 - fixedChars.count, currentReplacableChars.count].minElement()!
    if index <= 0 {
      return nil
    }

    return replacableStrings[currentReplacableIndex].attributedSubstringFromRange(NSRange(location: 0, length: index))
  }

  func computeText() -> NSAttributedString {
    let text = NSMutableAttributedString(attributedString: currentFixedString)
    if let replacableString = currentReplacableString {
      text.appendAttributedString(replacableString)
    }
    return text
  }

  override public func drawRect(rect: CGRect) {
    attributedText = computeText()
    super.drawRect(rect)
  }

  public func animationWithFixedString(fixedString: NSAttributedString, replacableStrings: [NSAttributedString], typeSpeed: NSTimeInterval, delay: NSTimeInterval, completion: (() -> Void)?) {
    self.fixedString = fixedString
    self.replacableStrings = replacableStrings
    reset()
    animation(typeSpeed: typeSpeed, delay: delay, completion: completion)
  }

  func animation(typeSpeed typeSpeed: NSTimeInterval, delay: NSTimeInterval, completion: (() -> Void)?) {
    if currentIndex == fixedChars.count && status == .Forward {
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
