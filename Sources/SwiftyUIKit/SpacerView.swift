//
//  SpacerView.swift
//  
//
//  Created by Sergey Kazakov on 30.11.2020.
//

import UIKit

public extension SpacerView {
    enum Axis {
        case horizontal
        case vertical
        case all
    }
}

public final class SpacerView: UIView {
    public init(for axis: Axis = .all) {
        super.init(frame: .zero)
        switch axis {
        case .horizontal:
            setContentHuggingPriority(.defaultLow, for: .horizontal)
        case .vertical:
            setContentHuggingPriority(.defaultLow, for: .vertical)
        case .all:
            setContentHuggingPriority(.defaultLow, for: .vertical)
            setContentHuggingPriority(.defaultLow, for: .horizontal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
