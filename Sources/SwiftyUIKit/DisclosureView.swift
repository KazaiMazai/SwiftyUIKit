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
    private static let veryLargeContraintValue: CGFloat = 9999
    private let isExpanded: () -> Bool
    private var conditionalContraints: [NSLayoutConstraint] = []

    public init(_ isExpanded: @escaping () -> Bool,
                axis: ExpandingAxis = .all,
                content: () -> UIView) {

        self.isExpanded = isExpanded
        let contentView = content()
        let conditionalContraints: [NSLayoutConstraint]

        switch axis {
        case .horizontal:
            conditionalContraints = [
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: Self.veryLargeContraintValue)
            ]
        case .vertical:
            conditionalContraints = [contentView.heightAnchor.constraint(
                lessThanOrEqualToConstant: Self.veryLargeContraintValue)
            ]
        case .all:
            conditionalContraints = [
                contentView.heightAnchor.constraint(
                    lessThanOrEqualToConstant: Self.veryLargeContraintValue),
                contentView.widthAnchor.constraint(
                    lessThanOrEqualToConstant: Self.veryLargeContraintValue)
            ]
        }

        super.init(frame: .zero)
        add(body: contentView)

        conditionalContraints.forEach {
            $0.constant = isExpanded() ? Self.veryLargeContraintValue : 0
            $0.priority = .defaultHigh
            $0.isActive = true
        }

        self.conditionalContraints = conditionalContraints
    }

    public override func updateConstraints() {
        super.updateConstraints()
        print("updateConstraints")
        conditionalContraints.forEach { $0.constant = isExpanded() ? Self.veryLargeContraintValue : 0 }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
