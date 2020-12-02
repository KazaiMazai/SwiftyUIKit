//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

@_functionBuilder
public struct ViewContentBuilder {
    public static func buildBlock(_ subviews: UIView...) -> [UIView] {
        subviews
    }
}
