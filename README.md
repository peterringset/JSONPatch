# JSONPatch
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/PRJSONPatch.svg)](https://img.shields.io/cocoapods/v/PRJSONPatch.svg)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

A Swift μ-framework for creating [RFC6902](https://tools.ietf.org/html/rfc6902) compliant [JSON patch](http://jsonpatch.com) objects

## Requirements

- iOS 8.0+ / macOS 10.13+
- Swift 4.2+

### IMPORTANT!

The framework relies on the Objective C runtime for converting keypaths into strings, and so it is crucial that the properties the keypaths point to are representable in Objective C. To achieve this, you will have to add the `@objc` annotation at each variable declaration.

```swift
class Patch: NSObject {
    @objc var baz: String!
    @objc var foo: String!
    @objc var hello: [String]!
}
```

Alternatively you can also use the `@objcMembers` annotation at the class level if all class members are representible in Objective C

```swift
@objcMembers class Patch: NSObject {
	...
}
```

## Installation
### Carthage

To integrate JSONPatch into your Xcode project using [Carthage](https://github.com/Carthage/Carthage), specify it in your `Cartfile`:

```ogdl
github "peterringset/JSONPatch" ~> 1.0
```

### CocoaPods

To integrate JSONPatch into your Xcode project using [CocoaPods](https://cocoapods.org), specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'PRJSONPatch', '~> 1.0'
end
```

### Swift package manger
To add a package dependency to your Xcode project, select File > Swift Packages > Add Package Dependency and enter `https://github.com/peterringset/JSONPatch`. 

## Usage

Create JSON patch objects using keypath's in Swift:

```swift
import JSONPatch

let stringChanges: [JSONPatch<Patch>] = [
    .replace(\.baz, value: "boo"),
    .remove(\.foo)
]
let arrayChanges: [JSONPatch<Patch>] = [
    .add(\.hello, value: ["world"])
]
```

Then, once you've created a collection of changes you can use `JSONEncoder` to convert it to json data:

```swift
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let data = try! encoder.encode(changes)
print(String(data: data, encoding: .utf8)!)
```

This will print the following json:

```json
[
  {
    "op" : "replace",
    "path" : "\/baz",
    "value" : "boo"
  },
  {
    "op" : "remove",
    "path" : "\/foo"
  },
  {
    "op" : "add",
    "path" : "\/hello",
    "value" : [
      "world"
    ]
  }
]
```

`JSONPatch` supports all the verbs specified in [RFC6902](https://tools.ietf.org/html/rfc6902), `add`, `remove`, `replace`, `move`, `copy` and `test`.
