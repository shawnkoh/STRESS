//
//  BKSettings.swift
//  Bounce
//
//  Created by Shawn Koh on 14/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import CoreGraphics

enum BKSettings {
    static let defaultMass: CGFloat = 2
    static let defaultDragCoefficient: CGFloat = 0.47
    static let defaultRestitution: CGFloat = 0.75
    static let restingDistanceMovedThreshold: CGFloat = 0.9
    static let restingCountThreshold = 11
}
