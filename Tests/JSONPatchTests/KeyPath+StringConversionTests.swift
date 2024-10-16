//
//  KeyPath+StringConversionTests.swift
//  JSONPatchTests
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import XCTest

@available(iOS 16.4, macOS 13.3, *)
class KeyPath_StringConversionTests: XCTestCase {

    func testKeyPath() {
        let string = String(describing: \MyStruct.child)
        XCTAssertEqual(string, "/child")
    }
    
    func testDeepKeyPath() {
        let string = String(describing: \MyStruct.child.name)
        XCTAssertEqual(string, "/child/name")
    }

}

private class MyStruct: NSObject {
    @objc let child: Child
    init(child: Child) {
        self.child = child
    }
}

private class Child: NSObject {
    @objc let name: String
    init(name: String) {
        self.name = name
    }
}
