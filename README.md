# JSONPatch

A Swift μ-framework for creating [RFC6902](https://tools.ietf.org/html/rfc6902) compliant [JSON patch](http://jsonpatch.com) objects

## Requirements

- iOS 16.4+ / macOS 13.3+

The `Package.swift` description declares requirements from iOS 16 and macOS 13, but in reality the requirement is actually iOS 16.4 and macOS 13.3. This is because the framework now relies on Swift's implementation of converting keypath's to strings, and that API is only available from iOS 16.4 and macOS 13.3.

## Installation
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
