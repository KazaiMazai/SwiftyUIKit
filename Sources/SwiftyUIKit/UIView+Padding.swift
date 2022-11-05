//
//  UIView+Padding.swift
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

    func padding(top: CGFloat = 0,
                 left: CGFloat = 0,
                 right: CGFloat = 0,
                 bottom: CGFloat = 0) -> UIView {
        PaddingViewDecorator(decorated: self,
                             topConstant: top,
                             leftConstant: left,
                             rightConstant: right,
                             bottomConstant: bottom)
    }

    func padding(vertical: CGFloat = 0, horizontal: CGFloat = 0) -> UIView {
        PaddingViewDecorator(decorated: self,
                             topConstant: vertical,
                             leftConstant: horizontal,
                             rightConstant: horizontal,
                             bottomConstant: vertical)
    }
}

private final class PaddingViewDecorator: UIView {
    convenience init(decorated: UIView, withPaddingConstant constant: CGFloat = 0) {
        self.init(decorated: decorated,
                  topConstant: constant,
                  leftConstant: constant,
                  rightConstant: constant,
                  bottomConstant: constant)
    }

    init(decorated: UIView,
         topConstant: CGFloat = 0,
         leftConstant: CGFloat = 0,
         rightConstant: CGFloat = 0,
         bottomConstant: CGFloat = 0) {
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
