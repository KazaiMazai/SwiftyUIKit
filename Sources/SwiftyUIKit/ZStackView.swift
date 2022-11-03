//
//  ZStackView.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension ZStackView {
     convenience init(alignment: Alignment = .all, @ViewContentBuilder content: () -> [UIView]) {
        self.init(alignment: alignment, content: content())
    }

    convenience init(alignment: Alignment = .all, @OptionalViewContentBuilder optionalContent: () -> [UIView]) {
        self.init(alignment: alignment, content: optionalContent())
    }
}

public final class ZStackView: UIView {
    public enum Alignment {
        case top
        case left
        case right
        case bottom
        case all
        case center
        case vertical
        case horizontal
    }

    public init(alignment: Alignment = .all,
                content: [UIView]) {
        super.init(frame: .zero)
        content.forEach {
            switch alignment {
            case .top:
                snapSubview($0, flexibleEdges: [.bottom])
            case .left:
                snapSubview($0, flexibleEdges: [.right])
            case .right:
                snapSubview($0, flexibleEdges: [.left])
            case .bottom:
                snapSubview($0, flexibleEdges: [.top])
            case .all:
                snapSubview($0, flexibleEdges: nil)
            case .center:
                snapSubview($0, flexibleEdges: FlexibleEdge.allCases, center: true)
            case .vertical:
                snapSubview($0, flexibleEdges: [.left, .right], center: true)
            case .horizontal:
                snapSubview($0, flexibleEdges: [.bottom, .top], center: true)
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
