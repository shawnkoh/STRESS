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
    var shape: PegShape
    var isHit: Bool = false

    init(type: PegType, shape: PegShape) {
        self.type = type
        self.shape = shape
    }
}

/**
The `PegType` enumeration represents the various types of pegs in Stress.
*/
enum PegType: Int {
    case blue
    /// A `green` peg provides a powerup when it is hit.
    case green
    /// An `orange` peg has to be eliminated in order to complete the level.
    case orange
}

/**
 The `PegShape` enumeration represents the various shapes of pegs in Stress.
 */
enum PegShape: Int {
    case circle
    case triangle
}
