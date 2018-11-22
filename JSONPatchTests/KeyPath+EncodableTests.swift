//
//  KeyPath+EncodableTests.swift
//  JSONPatchTests
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import XCTest

class KeyPath_EncodableTests: XCTestCase {

    lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(iOS 11, *) {
            encoder.outputFormatting = [.sortedKeys]
        }
        
        return encoder
    }()
    
    func testKeyPath() {
        let data = try! encoder.encode(KeyPathHolder(keyPath: \MyStruct.child))
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, "{\"keyPath\":\"\\/child\"}")
    }
    
    func testDeepKeyPath() {
        let data = try! encoder.encode(KeyPathHolder(keyPath: \MyStruct.child.name))
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, "{\"keyPath\":\"\\/child\\/name\"}")
    }

}

private struct KeyPathHolder<Root: NSObject, Value>: Encodable {
    let keyPath: KeyPath<Root, Value>
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
