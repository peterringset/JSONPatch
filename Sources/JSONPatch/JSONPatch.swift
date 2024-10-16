//
//  JSONPatch.swift
//  JSONPatch
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import Foundation

public struct JSONPatch<Root: NSObject> {
@available(iOS 16.4, macOS 13.3, *)
    
    typealias StringKeyPath = String
    
    enum Operation {
        case add(keyPath: StringKeyPath, value: AnyEncodable)
        case remove(keyPath: StringKeyPath)
        case replace(keyPath: StringKeyPath, value: AnyEncodable)
        case move(from: StringKeyPath, to: StringKeyPath)
        case copy(from: StringKeyPath, to: StringKeyPath)
        case test(keyPath: StringKeyPath, value: AnyEncodable)
    }
    
    let operation: Operation
    
    init(operation: Operation) {
        self.operation = operation
    }
    
    public static func add<V: Encodable>(_ keyPath: KeyPath<Root, V>, value: V) -> Self {
        return .init(operation: .add(keyPath: String(describing: keyPath), value: AnyEncodable(value)))
    }
    
    public static func remove<V>(_ keyPath: KeyPath<Root, V>) -> Self {
        return .init(operation: .remove(keyPath: String(describing: keyPath)))
    }
    
    public static func replace<V: Encodable>(_ keyPath: KeyPath<Root, V>, value: V) -> Self {
        return .init(operation: .replace(keyPath: String(describing: keyPath), value: AnyEncodable(value)))
    }
    
    public static func move<V>(from: KeyPath<Root, V>, to: KeyPath<Root, V>) -> Self {
        return .init(operation: .move(from: String(describing: from), to: String(describing: to)))
    }
    
    public static func copy<V>(from: KeyPath<Root, V>, to: KeyPath<Root, V>) -> Self {
        return .init(operation: .copy(from: String(describing: from), to: String(describing: to)))
    }
    
    public static func test<V: Encodable>(_ keyPath: KeyPath<Root, V>, value: V) -> Self {
        return .init(operation: .test(keyPath: String(describing: keyPath), value: AnyEncodable(value)))
    }
    
}

@available(iOS 16.4, macOS 13.3, *)
extension JSONPatch: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case operation = "op"
        case from
        case path
        case value
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(operationName, forKey: .operation)
        try container.encodeIfPresent(from, forKey: .from)
        try container.encode(path, forKey: .path)
        try container.encodeIfPresent(value, forKey: .value)
    }
    
    private var operationName: String {
        switch operation {
        case .add: return "add"
        case .remove: return "remove"
        case .replace: return "replace"
        case .move: return "move"
        case .copy: return "copy"
        case .test: return "test"
        }
    }
    
    private var from: StringKeyPath? {
        switch operation {
        case .move(let from, _): fallthrough
        case .copy(let from, _): return from
        case .add, .replace, .remove, .test: return nil
        }
    }
    
    private var path: StringKeyPath {
        switch operation {
        case .add(let keyPath, _): return keyPath
        case .remove(let keyPath): return keyPath
        case .replace(let keyPath, _): return keyPath
        case .move(_, let toKeyPath): return toKeyPath
        case .copy(_, let toKeyPath): return toKeyPath
        case .test(let keyPath, _): return keyPath
        }
    }
    
    private var value: AnyEncodable? {
        switch operation {
        case .add(_, let value): return value
        case .replace(_, let value): return value
        case .test(_, let value): return value
        case .remove, .move, .copy: return nil
        }
    }
    
}
