//
//  Spacer.swift
//  Stress
//
//  Created by Shawn Koh on 21/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import UIKit

/// A flexible space that expands along the specified axis
/// Credit: https://gist.github.com/morishin/639f5ff12c544eac9d7c64acbca54270
class Spacer: UIView {
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }

    init(axis: NSLayoutConstraint.Axis) {
        super.init(frame: .zero)
        setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
}
