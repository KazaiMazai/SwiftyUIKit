//
//  File.swift
//
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension DisclosureView {
    enum ExpandingAxis {
        case horizontal
        case vertical
        case all
    }
}

public final class DisclosureView: UIView {
    private let isExpanded: () -> Bool
    private var conditionalContraints: [NSLayoutConstraint]

    public init(_ isExpanded: @escaping () -> Bool,
                axis: ExpandingAxis = .all,
                content: () -> UIView) {

        self.isExpanded = isExpanded
        let contentView = content()
        let contraints: [NSLayoutConstraint]

        switch axis {
        case .horizontal:
            contraints = [
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: NSLayoutConstraint.defaultLargeConstant)
            ]
        case .vertical:
            contraints = [
                contentView.heightAnchor.constraint(
                lessThanOrEqualToConstant: NSLayoutConstraint.defaultLargeConstant)
            ]
        case .all:
            contraints = [
                contentView.heightAnchor.constraint(
                    lessThanOrEqualToConstant: NSLayoutConstraint.defaultLargeConstant),
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: NSLayoutConstraint.defaultLargeConstant)
            ]
        }

        self.conditionalContraints = contraints
        super.init(frame: .zero)
        add(body: contentView)

        contraints.forEach {
            $0.constant = isExpanded() ? NSLayoutConstraint.defaultLargeConstant : 0
            $0.priority = .defaultHigh
            $0.isActive = true
        }
    }

    public override func updateConstraints() {
        super.updateConstraints()
        print("updateConstraints")
        conditionalContraints.forEach { $0.constant = isExpanded() ? NSLayoutConstraint.defaultLargeConstant : 0 }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate extension NSLayoutConstraint {
    static let defaultLargeConstant: CGFloat = 9999
}
