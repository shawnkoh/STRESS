//
//  PegComponent.swift
//  Stress
//
//  Created by Shawn Koh on 26/2/20.
//  Copyright © 2020 Shawn Koh. All rights reserved.
//

import Foundation

class PegComponent: GKComponent {
    var type: PegType
    var isHit: Bool = false

    init(type: PegType) {
        self.type = type
    }
}

/**
 The `PegType` enumeration represents the various types of pegs in Stress.
 */
enum PegType: Int {
    /// An `objective` peg has to be eliminated in order to complete the level.
    /// When it is eliminated, it provides points.
    case objective
    /// A `normal` peg does not need to be eliminated in order to complete the level.
    /// When it is eliminated, it provides points.
    case normal
}
