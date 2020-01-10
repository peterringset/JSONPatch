//
//  JSONPatchTests.swift
//  JSONPatchTests
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import XCTest

@testable import JSONPatch

class JSONPatchTests: XCTestCase {

    lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(iOS 11, *) {
            encoder.outputFormatting = [.sortedKeys]
        }
        
        return encoder
    }()
    
    func testAdd() {
        let patch: JSONPatch<MyType> = .add(\.property, value: "addString")
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"op":"add","path":"\/property","value":"addString"}"#)
    }

    func testRemove() {
        let patch: JSONPatch<MyType> = .remove(\.property)
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"op":"remove","path":"\/property"}"#)
    }

    func testReplace() {
        let patch: JSONPatch<MyType> = .replace(\.property, value: "replaceString")
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"op":"replace","path":"\/property","value":"replaceString"}"#)
    }

    func testMove() {
        let patch: JSONPatch<MyType> = .move(from: \.property, to: \.secondProperty)
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"from":"\/property","op":"move","path":"\/secondProperty"}"#)
    }

    func testCopy() {
        let patch: JSONPatch<MyType> = .copy(from: \.property, to: \.secondProperty)
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"from":"\/property","op":"copy","path":"\/secondProperty"}"#)
    }

    func testTest() {
        let patch: JSONPatch<MyType> = .test(\.property, value: "testString")
        let data = try! encoder.encode(patch)
        let jsonString = String(data: data, encoding: .utf8)!
        XCTAssertEqual(jsonString, #"{"op":"test","path":"\/property","value":"testString"}"#)
    }

}

private class MyType: NSObject {
    
    @objc let property: String
    @objc let secondProperty: String
    
    override init() {
        property = "prop"
        secondProperty = "secondProp"
        
        super.init()
    }
    
}
