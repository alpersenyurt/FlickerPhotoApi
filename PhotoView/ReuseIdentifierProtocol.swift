//
//  ReuseIdentifierProtocol.swift
//  PhotoView
//
//  Created by Alper Senyurt on 13/07/16.
//  Copyright © 2016 Alper Senyurt. All rights reserved.
//


import UIKit


public protocol ReuseIdentifierProtocol: class {
    /// Get identifier from class
    static var defaultReuseIdentifier: String { get }
}

public extension ReuseIdentifierProtocol where Self: UIView {
    static var defaultReuseIdentifier: String {
        // Set the Identifier from class name
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}
