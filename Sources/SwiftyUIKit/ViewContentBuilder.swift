//
//  ViewContentBuilder.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

@resultBuilder
public struct ViewContentBuilder {
    public static func buildBlock(_ subviews: UIView...) -> [UIView] {
        subviews
    }
}

@resultBuilder
public struct OptionalViewContentBuilder {
    public static func buildBlock(_ subviews: UIView?...) -> [UIView] {
        subviews.compactMap { $0 }
    }
}
