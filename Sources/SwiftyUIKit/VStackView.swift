//
//  VStackView.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension VStackView {
     convenience init(spacing: CGFloat = 0, @ViewContentBuilder content: () -> [UIView]) {
        self.init(spacing: spacing, content: content())
    }

    convenience init(spacing: CGFloat = 0, @OptionalViewContentBuilder optionalContent: () -> [UIView]) {
        self.init(spacing: spacing, content: optionalContent())
    }
}

public final class VStackView: UIView {
    public init(spacing: CGFloat = 0,
                content: [UIView]) {
        super.init(frame: .zero)

        translatesAutoresizingMaskIntoConstraints = false
        content
            .enumerated()
            .forEach { (index, view) in
                let isFirst = index == 0
                let isLast = index == content.count - 1
                let previousView: UIView? = isFirst ? nil : content[index - 1]

                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)

                view.leftAnchor
                    .constraint(equalTo: leftAnchor)
                    .modify {
                        $0.priority = .defaultHigh
                        $0.isActive = true
                    }

                view.rightAnchor
                    .constraint(equalTo: rightAnchor)
                    .modify {
                        $0.priority = .defaultHigh
                        $0.isActive = true
                    }

                if isFirst {
                    view.topAnchor
                        .constraint(equalTo: topAnchor)
                        .modify {
                            $0.priority =  .defaultHigh
                            $0.isActive = true
                        }
                }

                if let prevView = previousView {
                    view.topAnchor
                        .constraint(equalTo: prevView.bottomAnchor,
                                    constant: spacing)
                        .modify {
                            $0.priority =  .defaultHigh
                            $0.isActive = true
                        }
                }

                if isLast {
                    view.bottomAnchor
                        .constraint(equalTo: bottomAnchor)
                        .modify {
                            $0.priority =  .defaultHigh
                            $0.isActive = true
                        }
                }
            }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
