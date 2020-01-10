//
//  KeyPath+StringConversion.swift
//  JSONPatch
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import Foundation

extension KeyPath: CustomStringConvertible {
    
    public var description: String {
        let path = NSExpression(forKeyPath: self)
            .keyPath
            .replacingOccurrences(of: ".", with: "/")
        return "/\(path)"
    }
    
}
