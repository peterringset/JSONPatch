//
//  JSONPatch.swift
//  JSONPatch
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import Foundation

import Foundation

enum JSONPatch<Root: NSObject, Value: Encodable> {
    
    case add(keyPath: KeyPath<Root, Value>, value: Value)
    case remove(keyPath: KeyPath<Root, Value>)
    case replace(keyPath: KeyPath<Root, Value>, value: Value)
    case move(fromKeyPath: KeyPath<Root, Value>, toKeyPath: KeyPath<Root, Value>)
    case copy(fromKeyPath: KeyPath<Root, Value>, toKeyPath: KeyPath<Root, Value>)
    case test(keyPath: KeyPath<Root, Value>, value: Value)
    
}

extension JSONPatch: Encodable {
    
    private enum CodingKeys: String, CodingKey {
        case operation = "op"
        case from
        case path
        case value
    }
    
    private enum Operation: String, Encodable {
        case add
        case remove
        case replace
        case move
        case copy
        case test
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(self.operation, forKey: .operation)
        if let from = self.from {
            try container.encode(from, forKey: .from)
        }
        try container.encode(self.path, forKey: .path)
        if let value = self.value {
            try container.encode(value, forKey: .value)
        }
    }
    
    private var operation: Operation {
        switch self {
        case .add: return .add
        case .remove: return .remove
        case .replace: return .replace
        case .move: return .move
        case .copy: return .copy
        case .test: return .test
        }
    }
    
    private var from: KeyPath<Root, Value>? {
        switch self {
        case .move(let fromKeyPath, _): return fromKeyPath
        case .copy(let fromKeyPath, _): return fromKeyPath
        case .add, .remove, .replace, .test: return nil
        }
    }
    
    private var path: KeyPath<Root, Value> {
        switch self {
        case .add(let keyPath, _): return keyPath
        case .remove(let keyPath): return keyPath
        case .replace(let keyPath, _): return keyPath
        case .move(_, let toKeyPath): return toKeyPath
        case .copy(_, let toKeyPath): return toKeyPath
        case .test(let keyPath, _): return keyPath
        }
    }
    
    private var value: Value? {
        switch self {
        case .add(_, let value): return value
        case .replace(_, let value): return value
        case .test(_, let value): return value
        case .remove, .move, .copy: return nil
        }
    }
    
}
