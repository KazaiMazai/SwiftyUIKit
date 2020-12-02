//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 01.12.2020.
//

import UIKit

public protocol Modifiable { }

public extension Modifiable {
    @discardableResult
    func modify(_ modifier: (Self) -> Void) -> Self {
        modifier(self)
        return self
    }
}

extension UIView: Modifiable { }

extension Array where Element: UIView {
    @discardableResult
    public func modify(_ modifier: (Element) -> Void) -> [Element] {
        forEach(modifier)
        return self
    }
}
