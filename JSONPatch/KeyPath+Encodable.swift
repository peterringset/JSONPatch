//
//  KeyPath+Encodable.swift
//  JSONPatch
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import Foundation

extension KeyPath: Encodable where Root: NSObject {
    
    public func encode(to encoder: Encoder) throws {
        let stringValue = NSExpression(forKeyPath: self).keyPath.replacingOccurrences(of: ".", with: "/")
        var container = encoder.singleValueContainer()
        try container.encode("/" + stringValue)
    }
    
}
