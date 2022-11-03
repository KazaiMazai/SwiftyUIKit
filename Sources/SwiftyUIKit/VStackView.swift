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
                
                constraints.append(view.leftAnchor.constraint(equalTo: leftAnchor))
                constraints.append(view.rightAnchor.constraint(equalTo: rightAnchor))
     
                if isFirst {
                    constraints.append(view.topAnchor.constraint(equalTo: topAnchor))
                }

                if let prevView {
                    constraints.append(view.topAnchor.constraint(
                        equalTo: prevView.bottomAnchor,
                        constant: spacing))
                }

                if isLast {
                    constraints.append(view.bottomAnchor.constraint(equalTo: bottomAnchor))
                }
            }
        
        constraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
