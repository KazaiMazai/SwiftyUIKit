//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

extension HStackView {
    public convenience init(spacing: CGFloat = 0, @ViewContentBuilder content: () -> [UIView]) {
        self.init(spacing: spacing, content: content())
    }
}

public final class HStackView: UIView {
    public init(spacing: CGFloat = 0,
                content: [UIView]) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        content
            .enumerated()
            .forEach { (index, view) in
                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)

                view.topAnchor.constraint(equalTo: topAnchor).isActive = true
                let bottomConstraint = view.bottomAnchor.constraint(equalTo: bottomAnchor)
                bottomConstraint.priority = .defaultHigh
                bottomConstraint.isActive = true

                if index == 0 {
                    view.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
                } else {
                    let prevView = content[index - 1]
                    view.leftAnchor.constraint(equalTo: prevView.rightAnchor,
                                                      constant: spacing).isActive = true
                }

                if index == content.count - 1 {
                    let rightConstraint = view.rightAnchor.constraint(equalTo: rightAnchor)
                    rightConstraint.priority = .defaultHigh
                    rightConstraint.isActive = true
                }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
