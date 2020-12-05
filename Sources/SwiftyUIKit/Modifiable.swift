//
//  File.swift
//
//
//  Created by Sergey Kazakov on 01.12.2020.
//

import UIKit
import Foundation

public protocol Modifiable { }

public extension Modifiable {
    @discardableResult
    func modify(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}

extension UIView: Modifiable { }

extension NSLayoutConstraint: Modifiable { }

extension NSLayoutAnchor: Modifiable { }

extension Array where Element: Modifiable {
    @discardableResult
    public func modify(_ modifier: (Element) -> Void) -> [Element] {
        forEach(modifier)
        return self
    }
}
