//
//  File.swift
//  
//
//  Created by Sergey Kazakov on 22.09.2020.
//

import UIKit

public extension UIView {
    func padding(_ all: CGFloat) -> UIView {
        PaddingViewDecorator(decorated: self,
                             topConstant: all,
                             leftConstant: all,
                             rightConstant: all,
                             bottomConstant: all)
    }

    func padding(topConstant: CGFloat = 0,
                 leftConstant: CGFloat = 0,
                 rightConstant: CGFloat = 0,
                 bottomConstant: CGFloat = 0) -> UIView {
        PaddingViewDecorator(decorated: self,
                             topConstant: topConstant,
                             leftConstant: leftConstant,
                             rightConstant: rightConstant,
                             bottomConstant: bottomConstant)
    }
}

private final class PaddingViewDecorator: UIView {
    convenience init(decorated: UIView, withPaddingConstant constant: CGFloat = 8) {
        self.init(decorated: decorated,
                  topConstant: constant,
                  leftConstant: constant,
                  rightConstant: constant,
                  bottomConstant: constant)
    }

    init(decorated: UIView,
         topConstant: CGFloat = 8,
         leftConstant: CGFloat = 8,
         rightConstant: CGFloat = 8,
         bottomConstant: CGFloat = 8) {
        super.init(frame: .zero)

        addSubview(decorated)
        decorated.translatesAutoresizingMaskIntoConstraints = false
        translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            decorated.topAnchor.constraint(equalTo: topAnchor, constant: topConstant),
            decorated.leftAnchor.constraint(equalTo: leftAnchor, constant: leftConstant),
            decorated.rightAnchor.constraint(equalTo: rightAnchor, constant: -1 * rightConstant),
            decorated.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1 * bottomConstant)
        ]

        constraints.forEach { $0.priority = .defaultHigh }
        NSLayoutConstraint.activate(constraints)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
