//
//  CGFloat+Extensions.swift
//  Stress
//
//  Created by Shawn Koh on 19/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    static func / (left: CGFloat, right: Int) -> CGFloat {
        CGFloat(left / CGFloat(right))
    }

    func abs() -> CGFloat {
        (self * self).squareRoot()
    }
}
