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
    initReplacableStringAtIndex(index: currentReplacableIndex)
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
        initReplacableStringAtIndex(index: currentReplacableIndex)
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
    let index = [currentIndex, fixedChars.count].min()!
    return fixedString.attributedSubstring(from: NSRange(location: 0, length: index))
  }

  var currentReplacableString: NSAttributedString? {
    let index = [currentIndex + 1 - fixedChars.count, currentReplacableChars.count].min()!
    if index <= 0 {
      return nil
    }

    return replacableStrings[currentReplacableIndex].attributedSubstring(from: NSRange(location: 0, length: index))
  }

  func computeText() -> NSAttributedString {
    let text = NSMutableAttributedString(attributedString: currentFixedString)
    if let replacableString = currentReplacableString {
      text.append(replacableString)
    }
    return text
  }

  override public func draw(_ rect: CGRect) {
    attributedText = computeText()
    super.draw(rect)
  }

  public func animationWithFixedString(fixedString: NSAttributedString, replacableStrings: [NSAttributedString], typeSpeed: TimeInterval, delay: TimeInterval, completion: (() -> Void)?) {
    self.fixedString = fixedString
    self.replacableStrings = replacableStrings
    reset()
    animation(typeSpeed: typeSpeed, delay: delay, completion: completion)
  }

  func animation(typeSpeed: TimeInterval, delay: TimeInterval, completion: (() -> Void)?) {
    if currentIndex == fixedChars.count && status == .Forward {
      Thread.sleep(forTimeInterval: delay)
    }
    UIView.animate(withDuration: typeSpeed, delay: delay, options: .curveEaseInOut, animations: {
      self.setNeedsDisplay()
    }) { _ in
      Thread.sleep(forTimeInterval: typeSpeed)
      self.next()
      if self.canAnimateNext() {
        self.animation(typeSpeed: typeSpeed, delay: delay, completion: completion)
      } else {
        completion?()
      }
    }
  }
}
