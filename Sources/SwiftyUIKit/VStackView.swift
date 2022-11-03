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
        var constrains = [NSLayoutConstraint]()
        translatesAutoresizingMaskIntoConstraints = false
        content
            .enumerated()
            .forEach { (index, view) in
                let isFirst = index == 0
                let isLast = index == content.count - 1
                let previousView: UIView? = isFirst ? nil : content[index - 1]

                view.translatesAutoresizingMaskIntoConstraints = false
                addSubview(view)
                
                constrains.append(view.leftAnchor.constraint(equalTo: leftAnchor))
                constrains.append(view.rightAnchor.constraint(equalTo: rightAnchor))
     
                if isFirst {
                    constrains.append(view.topAnchor.constraint(equalTo: topAnchor))
                }

                if let prevView = previousView {
                    constrains.append(view.topAnchor.constraint(
                        equalTo: prevView.bottomAnchor,
                        constant: spacing))
                }

                if isLast {
                    constrains.append(view.bottomAnchor.constraint(equalTo: bottomAnchor))
                }
            }
        
        constrains.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(constrains)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
