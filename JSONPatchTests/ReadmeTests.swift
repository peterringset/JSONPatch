//
//  ReadmeTests.swift
//  JSONPatchTests
//
//  Created by Peter Ringset on 10/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import JSONPatch
import XCTest

class ReadmeTests: XCTestCase {

    func testReadmeExampleCode() {
        let stringChanges: [JSONPatch<Patch>] = [
            .replace(\.baz, value: "boo"),
            .remove(\.foo)
        ]
        let arrayChanges: [JSONPatch<Patch>] = [
            .add(\.hello, value: ["world"])
        ]
        
        let changes = stringChanges + arrayChanges
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let data = try! encoder.encode(changes)
        print(String(data: data, encoding: .utf8)!)
        
        let expectedString = """
            [
              {
                "op" : "replace",
                "path" : "\\/baz",
                "value" : "boo"
              },
              {
                "op" : "remove",
                "path" : "\\/foo"
              },
              {
                "op" : "add",
                "path" : "\\/hello",
                "value" : [
                  "world"
                ]
              }
            ]
            """
        XCTAssertEqual(String(data: data, encoding: .utf8)!, expectedString)
    }

}

@objcMembers private class Patch: NSObject {
    let baz: String = ""
    let foo: String = ""
    let hello: [String] = []
}
