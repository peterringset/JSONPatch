//
//  KeyPath+StringConversion.swift
//  JSONPatch
//
//  Created by Peter Ringset on 22/11/2018.
//  Copyright © 2018 Ringset. All rights reserved.
//

import Foundation

@available(iOS 16.4, macOS 13.3, *)
extension KeyPath {
    var path: String {
        "/\(localPath)"
    }

    private var localPath: String {
        debugDescription.split(separator: ".").dropFirst().joined(separator: "/")
    }
}
