//
//  KeyPath+StringConversionTests.swift
//  JSONPatchTests
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import XCTest

@testable import JSONPatch

@available(iOS 16.4, macOS 13.3, *)
class KeyPath_StringConversionTests: XCTestCase {

    func testKeyPath() {
        let keyPath = \MyStruct.child
        let string = keyPath.path
        XCTAssertEqual(string, "/child")
    }
    
    func testDeepKeyPath() {
        let keyPath = \MyStruct.child.name
        let string = keyPath.path
        XCTAssertEqual(string, "/child/name")
    }

}

private struct MyStruct {
    let child: Child
}

private class Child {
    let name: String
    init(name: String) {
        self.name = name
    }
}
