# TypeOutAnimationLabel

An UILabel with type out animation, inspired from [https://connoratherton.com/typeout](https://connoratherton.com/typeout)

## Screenshot
![](https://cloud.githubusercontent.com/assets/5128246/14758910/4701a984-0939-11e6-8f92-75cdd3a123b0.gif)

## Installation

TypeOutAnimationLabel is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "TypeOutAnimationLabel"
```

## Example Usage
```swift
let font = UIFont.systemFontOfSize(20)
let fixedString = NSAttributedString(string: "San Francisco is ", attributes: [NSForegroundColorAttributeName: UIColor(red: 0.38, green: 0.388, blue: 0.404, alpha: 1), NSFontAttributeName: font])
let rString1 = NSAttributedString(string: "amazing", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.396, green: 0.82, blue: 0.396, alpha: 1), NSFontAttributeName: font ])
let rString2 = NSAttributedString(string: "beautiful", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.953, green: 0.612, blue: 0.0706, alpha: 1), NSFontAttributeName: UIFont.boldSystemFontOfSize(20) ])
let rString3 = NSAttributedString(string: "different", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.204, green: 0.596, blue: 0.859, alpha: 1), NSFontAttributeName: UIFont.italicSystemFontOfSize(20) ])
let rString4 = NSAttributedString(string: "an experience.", attributes: [ NSForegroundColorAttributeName: UIColor(red: 0.906, green: 0.298, blue: 0.235, alpha: 1), NSFontAttributeName: font ])

label.animationWithFixedString(fixedString, replaceableStrings: [rString1, rString2, rString3, rString4], typeSpeed: 0.1, delay: 2, completion: nil)
```


## Author

Buu Bui

## License

TypeOutAnimationLabel is available under the MIT license. See the LICENSE file for more info.
