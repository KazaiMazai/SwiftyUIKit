//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension DisclosureView {
    enum ExpandingDirection {
        case horizontal
        case vertical
        case all
    }
}

public final class DisclosureView: UIView {
    private let isExpanded: () -> Bool
    private var conditionalContraints: [NSLayoutConstraint] = []

    public init(_ isExpanded: @escaping () -> Bool,
                expandingDirection: ExpandingDirection = .all,
                content: () -> UIView) {

        self.isExpanded = isExpanded
        let contentView = content()
        let conditionalContraints: [NSLayoutConstraint]

        switch expandingDirection {
        case .horizontal:
            conditionalContraints = [
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: CGFloat.infinity)
            ]
        case .vertical:
            conditionalContraints = [contentView.heightAnchor.constraint(
                lessThanOrEqualToConstant: CGFloat.infinity)
            ]
        case .all:
            conditionalContraints = [
                contentView.heightAnchor.constraint(
                    lessThanOrEqualToConstant: CGFloat.infinity),
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: CGFloat.infinity)
            ]
        }

        super.init(frame: .zero)
        add(body:  contentView)

        self.conditionalContraints = conditionalContraints
        NSLayoutConstraint.activate(conditionalContraints)
    }

    public override func updateConstraints() {
        super.updateConstraints()
        conditionalContraints.forEach { $0.constant = isExpanded() ? .infinity : 0 }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
