//
//  HStackView.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension HStackView {
    convenience init(spacing: CGFloat = 0, @ViewContentBuilder contentBuilder: () -> [UIView]) {
        self.init(spacing: spacing, content: contentBuilder())
    }
}

public final class HStackView: UIView {
    public init(spacing: CGFloat = 0,
                content: [UIView]) {
        super.init(frame: .zero)
        var constraints = [NSLayoutConstraint]()
        translatesAutoresizingMaskIntoConstraints = false
        content
            .enumerated()
            .forEach { (index, view) in
                let isFirst = index == 0
                let isLast = index == content.count - 1
                let prevView: UIView? = isFirst ? nil : content[index - 1]

                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)
                
                constraints.append(view.topAnchor.constraint(equalTo: topAnchor))
                constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor))

                if isFirst {
                    constraints.append(view.leadingAnchor.constraint(equalTo: leadingAnchor))
                }

                if let prevView {
                    constraints.append(view.leadingAnchor.constraint(
                        equalTo: prevView.trailingAnchor,
                        constant: spacing))
                }

                if isLast {
                    constraints.append(view.trailingAnchor.constraint(equalTo: trailingAnchor))
                }
            }
        
        constraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
