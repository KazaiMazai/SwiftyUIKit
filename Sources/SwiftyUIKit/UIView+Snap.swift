//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension UIView {
    func add(body:  UIView) {
        snapSubview(body)
    }
}

internal extension UIView {
    enum FlexibleEdge: Int, Equatable, CaseIterable {
           case top
           case left
           case right
           case bottom
       }
}

internal extension UIView {
    func snapSubview(_ subview: UIView,
                     flexibleEdges: [FlexibleEdge]? = nil,
                     center: Bool = false) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false

        if center {
            NSLayoutConstraint.activate([
                subview.centerYAnchor.constraint(equalTo: centerYAnchor),
                subview.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }

        guard let flexibleEdges = flexibleEdges else {
            NSLayoutConstraint.activate([
                subview.leftAnchor.constraint(equalTo: leftAnchor),
                subview.rightAnchor.constraint(equalTo: rightAnchor),
                subview.topAnchor.constraint(equalTo: topAnchor),
                subview.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
            return
        }

        let edges = Set(flexibleEdges)

        NSLayoutConstraint.activate([
            edges.contains(.left) ?
                subview.leftAnchor.constraint(greaterThanOrEqualTo: leftAnchor)
                : subview.leftAnchor.constraint(equalTo: leftAnchor),
            edges.contains(.right) ?
                subview.rightAnchor.constraint(lessThanOrEqualTo: rightAnchor)
                :subview.rightAnchor.constraint(equalTo: rightAnchor),
            edges.contains(.top) ?
                subview.topAnchor.constraint(greaterThanOrEqualTo: topAnchor)
                :subview.topAnchor.constraint(equalTo: topAnchor),
            edges.contains(.bottom) ?
                subview.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor)
                :subview.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
