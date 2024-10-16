//
//  AnyEncodable.swift
//  JSONPatch
//
//  Created by Peter Ringset on 10/01/2020.
//  Copyright © 2020 Ringset. All rights reserved.
//

import Foundation

struct AnyEncodable: Encodable {
    
    let perform: (Encoder) throws -> Void
    
    init<V: Encodable>(_ value: V) {
        perform = { encoder in
            var container = encoder.singleValueContainer()
            try container.encode(value)
        }
    }
    
    func encode(to encoder: Encoder) throws {
        try perform(encoder)
    }
    
}
